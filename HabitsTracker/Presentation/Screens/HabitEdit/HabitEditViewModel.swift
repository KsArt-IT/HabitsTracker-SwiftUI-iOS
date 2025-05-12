//
//  HabitEditViewModel.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import Foundation

final class HabitEditViewModel: ObservableObject {
    private let repository: HabitRepository
    
    @Published private(set) var habit: Habit?
    @Published private(set) var edit = false
    @Published private(set) var closed = false
    
    @Published var cardTitle: String = ""
    
    @Published var periodDays: Int = 0
    private var weekDays: Set<WeekDays> = []
    
    @Published private(set) var times: [Int]
    private var intervals: [HourInterval] = [HourInterval(id: UUID(), time: 420)] {
        didSet {
            intervals.sort(by: <)
            times = intervals.map { $0.time }
        }
    }
    
    @Published var reminderTimes: Bool = false {
        didSet {
            if reminderTimes, !repository.notificationStatus() {
                repository.requestPermission()
            }
        }
    }
    
    private var task: Task<(), Never>?
    
    init(repository: HabitRepository) {
        self.repository = repository
        times = intervals.map { $0.time }
    }
    
    public func fetchHabit(by id: UUID?) async {
        print("HabitEditViewModel: \(#function) habit - \(id == nil ? "Create" : "Edit")")
        guard let id else {
            await startEdit()
            return
        }
        
        let result = await repository.fetchHabit(by: id, from: Date.now)
        switch result {
        case .success(nil):
            break
        case .success(let habit):
            await setHabit(habit)
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
        await startEdit()
    }
    
    public func checkDay(day: WeekDays) -> Bool {
        weekDays.contains(day)
    }
    
    public func changeDay(day: WeekDays, checked: Bool) {
        if checked {
            weekDays.insert(day)
        } else {
            weekDays.remove(day)
        }
    }
    
    public func changeTime(_ index: Int, _ time: Int) {
        guard 0..<intervals.count ~= index else { return }
        intervals[index] = intervals[index].copyWith(time: time)
    }
    
    public func timesAdd() {
        let interval = HourInterval(id: UUID(), time: (intervals.last?.time ?? 0) + 60)
        intervals.append(interval)
    }
    
    public func timesDel() {
        intervals.removeLast()
    }
    
    public func saveHabit() {
        print("HabitEditViewModel: \(#function)")
        guard task == nil else { return }
        let newTask = Task { [weak self] in
            if let habit = self?.habit {
                await self?.updateHabit(habit)
            } else {
                await self?.createHabit()
            }
            
            self?.task = nil
        }
        task = newTask
    }
    
    private func createHabit() async {
        print("HabitEditViewModel: \(#function)")
        guard let user = Profile.user else {
            await showMessage("User = nil")
            print("HabitEditViewModel::loadHabits: User = nil")
            await self.close()
            return
        }
        
        let habitId = UUID()
        let date = Date.now
        let daysOfWeek = periodDays == 0 ? Set<WeekDays>(WeekDays.allCases) : weekDays
        let notifications: [HabitNotification] = reminderTimes ? generateNotification(
            intervals,
            habitId: habitId,
            days: periodDays == 0 ? [] : daysOfWeek,
        ) : []
        
        let habit = Habit(
            id: habitId,
            userId: user.id,
            title: cardTitle,
            details: "",
            createdAt: date,
            updatedAt: date,
            completedAt: Date.distantFuture,
            weekDays: daysOfWeek,
            intervals: intervals,
            completed: [],
            notifications: notifications,
        )
        await saveHabit(habit)
    }
    
    private func generateNotification(
        _ intervals: [HourInterval],
        habitId: UUID,
        days: Set<WeekDays>,
    ) -> [HabitNotification] {
        guard !intervals.isEmpty else { return [] }
        
        var notifications: [HabitNotification] = []
        let repeats = true // повторять всегда, только если это не разовое оповещение
        
        for interval in intervals {
            if days.isEmpty {
                notifications.append(
                    getNotification(
                        habitId: habitId,
                        intervalId: interval.id,
                        weekDay: WeekDays.allDays,
                        time: interval.time,
                        repeats: repeats
                    )
                )
            } else {
                // на каждый день
                for day in days {
                    notifications.append(
                        getNotification(
                            habitId: habitId,
                            intervalId: interval.id,
                            weekDay: day.weekDay,
                            time: interval.time,
                            repeats: repeats
                        )
                    )
                }
            }
        }
        return notifications
    }
    
    private func getNotification(
        habitId: UUID,
        intervalId: UUID,
        weekDay: Int,
        time: Int,
        repeats: Bool = false
    ) -> HabitNotification {
        HabitNotification(
            id: UUID(),
            // NotificationDelegate change
            //----------- 0 ---- 1 ------- 2 ------ 3 ------- 4 ---- 5 -----
            identifier: "habit_\(habitId)_time_\(intervalId)_day_\(weekDay)",
            weekDay: weekDay,
            time: time,
            repeats: repeats,
            intervalId: intervalId
        )
    }
    
    private func updateHabit(_ habit: Habit) async {
        print("HabitEditViewModel: \(#function)")
        let daysOfWeek = periodDays == 0 ? Set<WeekDays>(WeekDays.allCases) : weekDays
        let notifications: [HabitNotification] = reminderTimes ? generateNotification(
            intervals,
            habitId: habit.id,
            days: periodDays == 0 ? [] : daysOfWeek,
        ) : []

        let habit = habit.copyWith(
            title: cardTitle,
            weekDays: daysOfWeek,
            intervals: intervals,
            notifications: notifications,
        )
        await saveHabit(habit)
    }
    
    private func saveHabit(_ habit: Habit) async {
        print("HabitEditViewModel: \(#function) intervals=\(habit.intervals.count)")
        let result  = await repository.saveHabit(habit)
        switch result {
        case .success(_):
            await self.close()
        case .failure(let error):
            await showMessage(error.localizedDescription)
        }
    }
    
    // MARK: - MainActor
    @MainActor
    private func startEdit() async {
        edit = true
    }
    
    @MainActor
    private func setHabit(_ habit: Habit?) async {
        guard let habit else { return }
        
        cardTitle = habit.title
        weekDays = habit.weekDays
        intervals = habit.intervals
        
        periodDays = weekDays.rawValue == WeekDays.allDays ? 0 : 1
        reminderTimes = !habit.notifications.isEmpty
        
        self.habit = habit
    }
    
    @MainActor
    private func showMessage(_ message: String) {
        print("HabitEditViewModel: message = \(message)")
    }
    
    @MainActor
    private func close() {
        print("HabitEditViewModel: \(#function)")
        closed = true
    }
}
