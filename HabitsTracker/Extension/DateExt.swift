//
//  DateExt.swift
//  HabitsTracker
//
//  Created by KsArT on 05.04.2025.
//

import Foundation

struct WeekRange {
    let start: Date
    let end: Date
}

struct MonthRange {
    let start: Date
    let end: Date
}

extension Date {
    /// Возвращает время в минутах от 0:00
    func toMinutesFromDate() -> Int {
        let hour = CalendarExt.calendar.component(.hour, from: self)
        let minute = CalendarExt.calendar.component(.minute, from: self)
        return hour * 60 + minute
    }
    
    /// Возвращает начало дня (00:00:00) для текущей даты
    var startOfDay: Date {
        CalendarExt.calendar.startOfDay(for: self)
    }
    
    /// Возвращает конец дня (23:59:59.999...) для текущей даты
    var endOfDay: Date {
        CalendarExt.calendar.date(byAdding: DateComponents(day: 1, second: -1), to: startOfDay)!
    }
    
    func previousDay() -> Date {
        CalendarExt.calendar.date(byAdding: .day, value: -1, to: self)!
    }
    
    func nextDay() -> Date {
        CalendarExt.calendar.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayMonthString: String {
        self.formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }
    
    /// Возвращает день недели
    var weekDay: Int {
        CalendarExt.calendar.component(.weekday, from: self)
    }
    
    /// Возвращает начало и конец недели
    func toWeekRange() -> WeekRange {
        let weekday = CalendarExt.calendar.component(.weekday, from: self)
        
        let startOfWeek = CalendarExt.calendar.date(
            byAdding: .day,
            value: -(weekday - CalendarExt.calendar.firstWeekday),
            to: self
        )!
        let endOfWeek = CalendarExt.calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        return WeekRange(start: startOfWeek.endOfDay, end: endOfWeek.endOfDay)
    }
    
    var weekOfYear: Int {
        CalendarExt.calendar.component(.weekOfYear, from: self)
    }

    func previousWeek() -> Date {
        CalendarExt.calendar.date(byAdding: .day, value: -7, to: self)!
    }
    
    func nextWeek() -> Date {
        CalendarExt.calendar.date(byAdding: .day, value: 7, to: self)!
    }
    
    /// Возвращает начало и конец месяца
    func toMonthRange() -> MonthRange {
        let components = CalendarExt.calendar.dateComponents([.year, .month], from: self)
        let start = CalendarExt.calendar.date(from: components)!
        
        var month = components.month! + 1
        var year = components.year!
        if month > 12 {
            month = 1
            year += 1
        }
        
        let endComponents = DateComponents(year: year, month: month, day: 0)
        let end = CalendarExt.calendar.date(from: endComponents)!
        
        return MonthRange(start: start.endOfDay, end: end.endOfDay)
    }
    
    func toMonthShort() -> String {
        CalendarExt.getMonthShort(from: self)
    }
    
    func inSameDay(_ date: Date) -> Bool {
        CalendarExt.calendar.isDate(self, inSameDayAs: date)
    }
    
    func month() -> Int {
        CalendarExt.calendar.component(.month, from: self)
    }
    
    func previousMonth() -> Date {
        CalendarExt.calendar.date(byAdding: .month, value: -1, to: self)!
    }
    
    func nextMonth() -> Date {
        CalendarExt.calendar.date(byAdding: .month, value: 1, to: self)!
    }
}
