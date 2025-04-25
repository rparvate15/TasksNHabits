//
//  ContentView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/27/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var taskList: TaskList
    @EnvironmentObject var habitList: HabitList
    
    @State private var isAddingTask = false
    @State private var isAddingHabit = false
    
    var body: some View {
        VStack {
            
            // Title Island
            VStack {
                Image(systemName: "checkmark.arrow.trianglehead.counterclockwise")
                    .font(.title.weight(.bold))
                    .background(Color.white.opacity(0.2))
                    .foregroundStyle(.purple)
                Text("TasksNHabits")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.purple)
            }
            .padding(.top, 25)
            .padding(.bottom, 25)
            
            // Tasks Island
            VStack {
                HStack {
                    Text("Tasks")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .padding()
                    Spacer()
                    
                    Button(action: {
                        isAddingTask = true
                    }) {
                        Image(systemName:"plus.circle")
                            .font(.title)
                    }
                    .padding()
                    .sheet(isPresented: $isAddingTask) {
                        AddTaskView().environmentObject(taskList)
                    }
                    
                }
                
                // Display list of Tasks
                if (taskList.tasks.isEmpty) {
                    Spacer()
                    Text("No tasks!")
                        .font(.headline)
                        .foregroundStyle(Color.purple)
                    Text("Click the plus button to add a new task")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                else {
                    ForEach(taskList.tasks.sorted(by: { ($0.isCompleted ? 1 : 0, $0.completeDate) < ($1.isCompleted ? 1 : 0, $1.completeDate) }), id: \.id) { task in
                        NavigationLink(destination: TaskDetailsView(task: task)) {
                            HStack {
//                              Checks if this task is overdue
//                                This is when the task is overdue
                                if (task.completeDate.timeIntervalSinceNow < 0) {
                                    Text(task.name)
                                        .padding(.horizontal)
                                        .padding(.trailing)
                                        .font(.subheadline)
                                        .foregroundStyle(Color.red)
                                    Text(task.completeDate.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption)
                                        .foregroundStyle(Color.red)
                                        .opacity(0.7)
                                }
//                                When task is not overdue
                                else {
                                    Text(task.name)
                                        .padding(.horizontal)
                                        .padding(.trailing)
                                        .font(.subheadline)
                                        .foregroundStyle(.purple)
                                    Text(task.timeUntil())
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .opacity(0.8)
                                    Text(" | ")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .opacity(0.7)
                                    Text(task.completeDate.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .opacity(0.8)
                                }
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        taskList.toggleTaskCompletion(id: task.id)
                                    }
                                }) {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(task.isCompleted ? .purple : .secondary)
                                        .padding(.horizontal)
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    taskList.deleteTask(id: task.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .transition(.move(edge: .leading))
                        }
                    }
                }
                Spacer()
            }
            .padding(.bottom, 25)
            
            
            
            // Habits Island
            VStack {
                HStack {
                    Text("Habits")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        isAddingTask = true
                    }) {
                        Image(systemName:"plus.circle")
                            .font(.title)
                    }
                    .padding()
                    .sheet(isPresented: $isAddingTask) {
                        AddTaskView().environmentObject(taskList)
                    }
                }
                
                // Display list of Habits
                if (habitList.habits.isEmpty) {
                    Spacer()
                    Text("No habits!")
                        .font(.headline)
                        .foregroundStyle(Color.purple)
                    Text("Click the plus button to add a new habit")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        
                }
                else {
                    List {
                        ForEach(habitList.habits, id: \.name) { eachHabit in
                            Text(eachHabit.name)
                        }
                    }
                }
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskList())
        .environmentObject(HabitList())
}
