//
//  TaskList.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/31/25.
//

import Foundation
import SwiftUI

class TaskList: ObservableObject {
    @Published var tasks: [Task] = []
    
    public func addTask(task: Task) {
        objectWillChange.send()
        tasks.append(task)
    }
    
    func toggleTaskCompletion(id: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            var updatedTask = tasks[index]
            updatedTask.isCompleted.toggle()
            tasks[index] = updatedTask
        }
    }
    
    func deleteTask(id: UUID) {
        tasks.removeAll(where: { $0.id == id })
    }
}
