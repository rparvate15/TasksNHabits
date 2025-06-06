//
//  TasksNHabitsApp.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/27/25.
//

import SwiftUI

@main
struct TasksNHabitsApp: App {
    @StateObject var taskList = TaskList()
    @StateObject var habitList = HabitList()
    
    init() {
        NotificationManager.shared.requestPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(taskList)
                    .environmentObject(habitList)
            }
        }
    }
}
