//
//  TaskListView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/1/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskList: TaskList
    
    var body: some View {
        List {
            ForEach(taskList.tasks.sorted(by: { ($0.isCompleted ? 1 : 0, $0.completeDate) < ($1.isCompleted ? 1 : 0, $1.completeDate) }), id: \.id) { task in
                NavigationLink(destination: TaskDetailsView(task: task)) {
                    HStack {
                        // Task name
                        Text(task.name)
                            .font(.subheadline)
                            .foregroundColor(task.completeDate.timeIntervalSinceNow < 0 ? .red : .purple)
                        
                        Spacer() // Pushes content to trailing edge
                        
                        // Time information and button group
                        HStack() {
                            if task.completeDate.timeIntervalSinceNow < 0 {
                                Text(task.completeDate.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.red)
                            } else {
                                Text(task.timeUntil())
                                Text("|")
                                Text(task.completeDate.formatted(date: .abbreviated, time: .shortened))
                            }
                            
                            // Checkmark button
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    taskList.toggleTaskCompletion(id: task.id)
                                }
                            } label: {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(task.isCompleted ? .purple : .gray)
                            }
                        }
                        .font(.caption)
                        .foregroundColor(task.completeDate.timeIntervalSinceNow < 0 ? .red : .secondary)
                    }
                    .padding(.vertical, 8)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        taskList.deleteTask(id: task.id)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    TaskListView()
        .environmentObject(TaskList())
}
