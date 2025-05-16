//
//  TaskDetailsView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/28/25.
//

import SwiftUI

struct TaskDetailsView: View {
    var task: Task
    @Environment(\.dismiss) var dismiss
    @State private var dueDate: Date = Date()
    
    var body: some View {
        VStack {
            Spacer()
            Text(task.name)
                .font(.title)
                .foregroundStyle(.purple)
                .padding(.vertical)
            if !task.description.isEmpty {
                Text(task.description)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            else {
                Text("Empty description")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .italic()
                    .opacity(0.3)
            }
            
            
            VStack {
                Text(task.timeToString())
                    .font(.title2)
                    .foregroundStyle(.purple)
                    .padding(.top, 50)
                Text(task.dateToString())
                    .font(.title2)
                    .foregroundStyle(.purple)
            }
            
            
            Spacer()
            
            
            
            Spacer()
            
            if (task.completeDate.timeIntervalSinceNow > 0)
            {
                Text("Time Until Due: " + String(task.timeUntil()))
                    .multilineTextAlignment(TextAlignment.center)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            else {
                Text("Time Since Due: " + String(task.timeUntil()))
                    .multilineTextAlignment(TextAlignment.center)
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    TaskDetailsView(task: Task.init(name: "Test Task", description: "", completeDate: Date(timeIntervalSinceNow: 3541)))
}
