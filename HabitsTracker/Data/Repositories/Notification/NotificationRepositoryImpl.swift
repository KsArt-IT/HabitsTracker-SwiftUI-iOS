//
//  NotificationRepositoryImpl.swift
//  HabitsTracker
//
//  Created by KsArT on 12.05.2025.
//

import Foundation

final class NotificationRepositoryImpl: NotificationRepository {
    private let service: DataService

    init(service: DataService) {
        self.service = service
    }
    
    func completed(habitId: UUID, intervalId: UUID) async -> Bool {
        print("NotificationRepositoryImpl: \(#function)")
        if let interval = await service.fetchInterval(habitId: habitId, intervalId: intervalId) {
            if (await service.fetchCompleted(habitId: habitId, intervalId: intervalId, date: Date.now)) == nil {
                let completed = HourIntervalCompletedModel(
                    habitId: habitId,
                    intervalId: interval.id,
                    time: interval.time,
                )
                if case .success(_) = await service.saveCompleted(completed) {
                    // оповестим, что нужно обновить habit
                    service.reloadHabit(by: habitId)
                    return true
                }
            }
        }
        return false
    }

}
