//
//  habit.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/27/25.
//

import Foundation
import UIKit
import SwiftUICore

public struct Habit: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    var description: String
    var frequency: Frequency
    var totalAmount: Int
    var currentAmount: Int
    var lastIntervalStart: Date?
    
    init(id: UUID = UUID(), name: String, description: String, frequency: Frequency, totalAmount: Int, currentAmount: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.frequency = frequency
        self.totalAmount = totalAmount
        self.currentAmount = currentAmount
        self.lastIntervalStart = startOfCurrentInterval(for: Date())
    }

    public func HabitPreviewString() -> String {
        let times = totalAmount == 1 ? "time" : "times"
        
        var frequencyString : String {
            if frequency == .daily {
                return "day"
            }
            else if frequency == .weekly {
                return "week"
            }
            else if frequency == .monthly {
                return "month"
            }
            else if frequency == .yearly {
                return "year"
            }
            else {
                return("Unexpected error: Due to Frequency")
            }
        }
        
        return name + " " + String(totalAmount) + " " + times + " a " + frequencyString
    }
    
    private func TimeIntervalCalculator(currentDate: Date = Date()) -> (day: TimeInterval, week: TimeInterval, month: TimeInterval, year: TimeInterval) {
        let calendar = Calendar.current
        let now = currentDate
        
        let nextDay = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now))!
        
        let nextWeek = calendar.nextDate(after: .now, matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday), matchingPolicy: .nextTime)!
        
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: calendar.startOfDay(for: now))!
            .startOfMonth(using: calendar)
        
        
        let currentYear = calendar.component(.year, from: now)
        var yearComponent = DateComponents()
        yearComponent.year = currentYear + 1
        yearComponent.month = 1
        yearComponent.day = 1
        yearComponent.hour = 0
        yearComponent.minute = 0
        yearComponent.second = 0
        
        
        let nextYear = calendar.date(from: yearComponent)!
        
        return (
            day: nextDay.timeIntervalSinceNow,
            week: nextWeek.timeIntervalSinceNow,
            month: nextMonth.timeIntervalSinceNow,
            year: nextYear.timeIntervalSinceNow
        )
    }
    
    private func TimeUntilDay(currentDate: Date) -> String {
        var returnString = ""
        var hours = 0
        var minutes = 0
        var seconds = 0
        var timeSeconds = TimeIntervalCalculator().day
        
        hours = Int(timeSeconds) / 3600
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 3600)
        minutes = Int(timeSeconds) / 60
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 60)
        seconds = Int(timeSeconds)
        
        if hours > 0 {
            if hours == 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hour, ")
            }
            else if hours == 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + " hour")
            }
            else if hours > 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hours, ")
            }
            else if hours > 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + " hours")
            }
        }
        if minutes > 0 {
            if minutes == 1 && seconds != 0 {
                returnString.append(String(minutes) + " minute, ")
            }
            else if minutes == 1 && seconds == 0 {
                returnString.append(String(minutes) + " minute")
            }
            else if minutes > 1 && seconds != 0 {
                returnString.append(String(minutes) + " minutes, ")
            }
            else if minutes > 1 && seconds == 0 {
                returnString.append(String(minutes) + "minutes")
            }
        }
        if seconds > 1 {
            returnString.append(String(seconds) + " seconds")
        }
        else if seconds == 1{
            returnString.append(String(seconds) + " second")
        }
        
    
        return returnString
    }
    
    private func TimeUntilWeek(currentDate: Date) -> String {
        var returnString = ""
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var timeSeconds = TimeIntervalCalculator().week
        
        days = Int(timeSeconds) / 86400
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 86400)
        hours = Int(timeSeconds) / 3600
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 3600)
        minutes = Int(timeSeconds) / 60
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 60)
        seconds = Int(timeSeconds)
        
        if days > 0 {
            if days == 1 && (hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(days) + " day, ")
            }
            else if days == 1 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(days) + " day")
            }
            else if days > 1 && (hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(days) + " days, ")
            }
            else if days > 1 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(days) + " days")
            }
        }
        if hours > 0 {
            if hours == 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hour, ")
            }
            else if hours == 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + " hour")
            }
            else if hours > 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hours, ")
            }
            else if hours > 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + "hours")
            }
        }
        if minutes > 0 {
            if minutes == 1 && seconds != 0 {
                returnString.append(String(minutes) + " minute, ")
            }
            else if minutes == 1 && seconds == 0 {
                returnString.append(String(minutes) + " minute")
            }
            else if minutes > 1 && seconds != 0 {
                returnString.append(String(minutes) + " minutes, ")
            }
            else if minutes > 1 && seconds == 0 {
                returnString.append(String(minutes) + "minutes")
            }
        }
        if seconds > 1 {
            returnString.append(String(seconds) + " seconds")
        }
        else if seconds == 1 {
            returnString.append(String(seconds) + " second")
        }
        
        return returnString
    }
    
    private func TimeUntilMonth(currentDate: Date) -> String {
        var returnString = ""
        var weeks = 0
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var timeSeconds = TimeIntervalCalculator().month
        
        weeks = Int(timeSeconds) / 604800
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 604800)
        days = Int(timeSeconds) / 86400
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 86400)
        hours = Int(timeSeconds) / 3600
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 3600)
        minutes = Int(timeSeconds) / 60
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 60)
        seconds = Int(timeSeconds)
        
        if weeks > 0 {
            if weeks == 1 && (days != 0 || hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(weeks) + " week, ")
            }
            else if weeks == 1 && days == 0 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(weeks) + " week")
            }
            else if weeks > 1 && (days != 0 || hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(weeks) + " weeks, ")
            }
            else if weeks > 1 && days == 0 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(weeks) + " weeks")
            }
        }
        if days > 0 {
            if days == 1 && (hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(days) + " day, ")
            }
            else if days == 1 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(days) + " day")
            }
            else if days > 1 && (hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(days) + " days, ")
            }
            else if days > 1 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(days) + " days")
            }
        }
        if hours > 0 {
            if hours == 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hour, ")
            }
            else if hours == 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + " hour")
            }
            else if hours > 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hours, ")
            }
            else if hours > 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + "hours")
            }
        }
        if minutes > 0 {
            if minutes == 1 && seconds != 0 {
                returnString.append(String(minutes) + " minute, ")
            }
            else if minutes == 1 && seconds == 0 {
                returnString.append(String(minutes) + " minute")
            }
            else if minutes > 1 && seconds != 0 {
                returnString.append(String(minutes) + " minutes, ")
            }
            else if minutes > 1 && seconds == 0 {
                returnString.append(String(minutes) + " minutes")
            }
        }
        if seconds > 1 {
            returnString.append(String(seconds) + " seconds")
        }
        else if seconds == 1{
            returnString.append(String(seconds) + " second")
        }
        
        return returnString
    }
    
    private func TimeUntilYear(currentDate: Date) -> String {
        var returnString = ""
        var weeks = 0
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var timeSeconds = TimeIntervalCalculator().year
        
        weeks = Int(timeSeconds) / 604800
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 604800)
        days = Int(timeSeconds) / 86400
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 86400)
        hours = Int(timeSeconds) / 3600
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 3600)
        minutes = Int(timeSeconds) / 60
        timeSeconds = timeSeconds.truncatingRemainder(dividingBy: 60)
        seconds = Int(timeSeconds)
        
        if weeks > 0 {
            if weeks == 1 && (days != 0 || hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(weeks) + " week, ")
            }
            else if weeks == 1 && days == 0 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(weeks) + " week")
            }
            else if weeks > 1 && (days != 0 || hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(weeks) + " weeks, ")
            }
            else if weeks > 1 && days == 0 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(weeks) + " weeks")
            }
        }
        if days > 0 {
            if days == 1 && (hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(days) + " day, ")
            }
            else if days == 1 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(days) + " day")
            }
            else if days > 1 && (hours != 0 || minutes != 0 || seconds != 0) {
                returnString.append(String(days) + " days, ")
            }
            else if days > 1 && hours == 0 && minutes == 0 && seconds == 0 {
                returnString.append(String(days) + " days")
            }
        }
        if hours > 0 {
            if hours == 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hour, ")
            }
            else if hours == 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + " hour")
            }
            else if hours > 1 && (minutes != 0 || seconds != 0) {
                returnString.append(String(hours) + " hours, ")
            }
            else if hours > 1 && minutes == 0 && seconds == 0 {
                returnString.append(String(hours) + " hours")
            }
        }
        if minutes > 0 {
            if minutes == 1 && seconds != 0 {
                returnString.append(String(minutes) + " minute, ")
            }
            else if minutes == 1 && seconds == 0 {
                returnString.append(String(minutes) + " minute")
            }
            else if minutes > 1 && seconds != 0 {
                returnString.append(String(minutes) + " minutes, ")
            }
            else if minutes > 1 && seconds == 0 {
                returnString.append(String(minutes) + " minutes")
            }
        }
        if seconds > 1 {
            returnString.append(String(seconds) + " seconds")
        }
        else if seconds == 1{
            returnString.append(String(seconds) + " second")
        }
        
        return returnString
    }
    
    public func TimeUntil(currentDate: Date = Date()) -> String {
        switch frequency {
        case .daily:
            return TimeUntilDay(currentDate: currentDate)
        case .weekly:
            return TimeUntilWeek(currentDate: currentDate)
        case .monthly:
            return TimeUntilMonth(currentDate: currentDate)
        case .yearly:
            return TimeUntilYear(currentDate: currentDate)
        }
    }
    
    private func startOfCurrentInterval(for date: Date) -> Date {
        let calendar = Calendar.current
        switch frequency {
        case .daily:
            return calendar.startOfDay(for: date)
        case .weekly:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        case .monthly:
            return calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        case .yearly:
            return calendar.date(from: calendar.dateComponents([.year], from: date))!
        }
    }
    
    public mutating func resetIfNeeded(currentDate: Date = Date()) -> Bool {
        let currentIntervalStart = startOfCurrentInterval(for: currentDate)
        
        guard let lastStart = lastIntervalStart else {
            lastIntervalStart = currentIntervalStart
            return false
        }
        
        if currentIntervalStart > lastStart {
            currentAmount = 0
            lastIntervalStart = currentIntervalStart
            return true
        }
        return false
    }
    
    public func nextResetDate() -> Date {
        let timeIntervals = TimeIntervalCalculator()
        switch frequency {
        case .daily:
            return Date().addingTimeInterval(timeIntervals.day)
        case .weekly:
            return Date().addingTimeInterval(timeIntervals.week)
        case .monthly:
            return Date().addingTimeInterval(timeIntervals.month)
        case .yearly:
            return Date().addingTimeInterval(timeIntervals.year)
        }
    }
    
    // TODO: Add a function that calculates if a habit is "on track" (takes into account amount over time)
}
