//
//  HabitList.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/31/25.
//

import Foundation
import SwiftUI

class HabitList: ObservableObject {
    @Published var habits: [Habit] = []
    
    public func addHabit(habit: Habit) {
        habits.append(habit)
    }
    
}
