//
//  Task.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/27/25.
//

import Foundation
import UIKit
import SwiftUICore

public struct Task: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    var description: String
    var completeDate: Date = Date(timeIntervalSinceNow: 0)
    public var isCompleted: Bool = false
    
    init() {
        name = "Task Template"
        description = "Description Template"
    }
    
    init (name: String) {
        self.name = name
        description = "Description Placeholder"
    }
    
    init (name: String, description: String) {
        self.name = name
        self.description = description
    }

    init (name: String, description: String, completeDate: Date) {
        self.name = name
        self.description = description
        self.completeDate = completeDate
    }
    
    init (name: String, completeDate: Date) {
        self.name = name
        self.description = "Description Placeholder"
        self.completeDate = completeDate
    }
    
    public func timeUntil() -> String {
        var returnString = ""
        var hours = 0
        var minutes = 0
        var seconds = 0
        var secondsUntil: Double = completeDate.timeIntervalSinceNow
        
        hours = Int(secondsUntil) / 3600
        secondsUntil = secondsUntil.truncatingRemainder(dividingBy: 3600)
        minutes = Int(secondsUntil) / 60
        secondsUntil = secondsUntil.truncatingRemainder(dividingBy: 60)
        seconds = Int(secondsUntil)
        
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
    
    
    func dateToString() -> String {
        return completeDate.formatted(date: .long, time: .omitted)
    }
    
    func timeToString() -> String {
        return completeDate.formatted(date: .omitted, time: .shortened)
    }
}

