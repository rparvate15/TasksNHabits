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
}
