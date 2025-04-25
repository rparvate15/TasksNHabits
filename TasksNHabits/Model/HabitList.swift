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
            try data.write(to: URL(fileURLWithPath: "habits.json"))
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
    }
    
    public func addHabit(habit: Habit) {
        objectWillChange.send()
        habits.append(habit)
    }
    
    func deleteHabit(id: UUID) {
        objectWillChange.send()
        habits.removeAll { $0.id == id }
    }
    
}
