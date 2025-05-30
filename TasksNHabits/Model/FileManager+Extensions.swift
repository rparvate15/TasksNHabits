//
//  FileManager+Extensions.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 4/25/25.
//

import Foundation

extension FileManager {
    static var sharedContainer: URL {
        FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.com.rudraparvate.TasksNHabits"
        )!
    }
}

extension Date {
    func startOfMonth(using calendar: Calendar = .current) -> Date {
           calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
       }
       
       func startOfYear(using calendar: Calendar = .current) -> Date {
           calendar.date(from: calendar.dateComponents([.year], from: self))!
       }
}
