//
//  HabitList.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/31/25.
//

import Foundation
import SwiftUI

class HabitList: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            saveHabits()
        }
    }
    
    init() {
        loadHabits()
    }
    
    private func saveHabits() {
        do {
            let data = try JSONEncoder().encode(habits)
            try data.write(to: FileManager.documentsDirectory.appendingPathComponent("habits.json"))
        } catch {
            print("Error saving habits: \(error)")
        }
    }
    
    private func loadHabits() {
        let url = FileManager.documentsDirectory.appendingPathComponent("habits.json")
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            habits = try JSONDecoder().decode([Habit].self , from: data)
        } catch {
            print("Error loading habits: \(error)")
        }
        resetHabitsIfNeeded()
    }
    
    public func addHabit(habit: Habit) {
        objectWillChange.send()
        habits.append(habit)
        NotificationManager.shared.scheduleHabitResetNotification(for: habit)
    }
    
    func deleteHabit(id: UUID) {
        objectWillChange.send()
        habits.removeAll { $0.id == id }
        NotificationManager.shared.cancelNotification(for: id)
    }
    
    func incrementHabit(id: UUID) {
        if let index = habits.firstIndex(where: { $0.id == id }) {
            var habit = habits[index]
            habit.currentAmount = min(habit.currentAmount + 1, habit.totalAmount)
            habits[index] = habit
        }
    }

    func decrementHabit(id: UUID) {
        if let index = habits.firstIndex(where: { $0.id == id }) {
            var habit = habits[index]
            habit.currentAmount = max(habit.currentAmount - 1, 0)
            habits[index] = habit
        }
    }
    
    public func resetHabitsIfNeeded() {
        let now = Date()
        for index in habits.indices {
            if habits[index].resetIfNeeded(currentDate: now) {
                // Habit was reset - schedule next notification
                NotificationManager.shared.scheduleHabitResetNotification(for: habits[index])
            }
        }
        saveHabits()
    }
}
