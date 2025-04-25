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

public struct Habit {
    public let id = UUID()
    public var name: String
    var description: String
    var frequency: Frequency
    var totalAmount: Int
    var currentAmount: Int
    private var isCompleted: Bool = false
}
