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
    
    func timeUntil() -> String {
        var secondsUntil: Double = completeDate.timeIntervalSinceNow
        var stringToAdd: String = ""
        var stringReturn: String = ""
        if (secondsUntil < 0) {
            secondsUntil *= -1
        }
        if secondsUntil >= 86400 {
            stringToAdd = String(format: "%.0f", (secondsUntil/86400).rounded())
            stringReturn.append(stringToAdd + " days, ")
            secondsUntil = secondsUntil.truncatingRemainder(dividingBy: 86400)
        }
        if secondsUntil >= 3600 {
            stringToAdd = String(format: "%.0f", (secondsUntil/3600).rounded())
            stringReturn.append(stringToAdd + " hours, ")
            secondsUntil = secondsUntil.truncatingRemainder(dividingBy: 3600)
        }
        if secondsUntil >= 60 {
            stringToAdd = String(format: "%.0f", (secondsUntil/60).rounded())
            stringReturn.append(stringToAdd + " minutes")
            secondsUntil = secondsUntil.truncatingRemainder(dividingBy: 60)
        }
        if stringReturn == "" {
            return "Less than a minute!"
        }
        return stringReturn
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm E, MMM dd, yyyy"
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: completeDate)
    }
    
    func timeToString() -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: completeDate)
    }
}

