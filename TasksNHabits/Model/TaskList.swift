//
//  TaskList.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/31/25.
//

import Foundation
import SwiftUI

class TaskList: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    init() {
        loadTasks()
    }
    
    public func addTask(task: Task) {
        objectWillChange.send()
        tasks.append(task)
    }
    
    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: FileManager.documentsDirectory.appendingPathComponent("tasks.json"))
        } catch {
            print("Error saving tasks: \(error)")
        }
    }
    
    private func loadTasks() {
        let url = FileManager.documentsDirectory.appendingPathComponent("tasks.json")
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error loading tasks: \(error)")
        }
    }
    
    func toggleTaskCompletion(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            var updatedTask = tasks[index]
            updatedTask.isCompleted.toggle()
            tasks[index] = updatedTask
        }
    }
    
    func deleteTask(id: UUID) {
        objectWillChange.send()
        tasks.removeAll(where: { $0.id == id })
    }
}
