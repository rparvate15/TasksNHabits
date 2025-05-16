//
//  TaskListView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/1/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskList: TaskList
    @State private var taskToDelete: Task?
    
    var body: some View {
        List {
            ForEach(taskList.tasks.sorted(by: { ($0.isCompleted ? 1 : 0, $0.completeDate) < ($1.isCompleted ? 1 : 0, $1.completeDate) }), id: \.id) { task in
                NavigationLink(destination: TaskDetailsView(task: task)) {
                    HStack {
                        // Task name
                        Text(task.name)
                            .font(.subheadline)
                            .foregroundColor(task.completeDate.timeIntervalSinceNow < 0 ? .red : (task.isCompleted ? .secondary : .purple))
                        
                        Spacer() // Pushes content to trailing edge
                        
                        // Time information and button group
                        HStack() {
                            if task.completeDate.timeIntervalSinceNow < 0 {
                                Text(task.completeDate.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.red)
                            } else {
                                Text(task.timeUntil())
                                    .font(.caption)
                                    .opacity(0.5)
                                Text("|")
                                    .font(.caption)
                                    .opacity(0.5)
                                Text(task.completeDate.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .opacity(0.5)
                            }
                            
                            // Checkmark button
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(task.isCompleted ? .purple : .gray)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        taskList.toggleTaskCompletion(id: task.id)
                                    }
                                }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            taskToDelete = task
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .contextMenu() {
                        Button(role: .destructive) {
                            taskToDelete = task
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .transition(.opacity.combined(with: .move(edge: .leading)))
        }
        .confirmationDialog(
            "Delete Task",
            isPresented: .constant(taskToDelete != nil),
            actions: {
                Button("Delete", role: .destructive) {
                    if let task = taskToDelete {
                        withAnimation(.easeOut(duration: 0.2)) {
                            taskList.deleteTask(id: task.id)
                        }
                        taskToDelete = nil
                    }
                }
                Button("Cancel", role: .cancel) {
                    taskToDelete = nil
                }
            },
            message: {
                Text("Are you sure you want to delete \(taskToDelete?.name ?? "this task?")")
            }
        )
        .listStyle(.plain)
    }
}

#Preview {
    TaskListView()
        .environmentObject(TaskList())
}
