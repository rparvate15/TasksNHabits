//
//  habit.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/27/25.
//

import Foundation

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
    private var isCompleted: Bool = false
    
    init(id: UUID = UUID(), name: String, description: String, frequency: Frequency, totalAmount: Int, currentAmount: Int, isCompleted: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.frequency = frequency
        self.totalAmount = totalAmount
        self.currentAmount = currentAmount
        self.isCompleted = isCompleted
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
}
