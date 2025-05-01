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
        NavigationStack {
            VStack {
                
                // Title Island
                VStack {
                    Image(systemName: "checkmark.arrow.trianglehead.counterclockwise")
                        .font(.title.weight(.bold))
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
                        TaskListView()
                    }
                    Spacer()
                }
                
                
                
                // Habits Island
                VStack {
                    HStack {
                        Text("Habits")
                            .font(.title)
                            .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            isAddingHabit = true
                        }) {
                            Image(systemName:"plus.circle")
                                .font(.title)
                        }
                        .padding()
                        .sheet(isPresented: $isAddingHabit) {
                            AddHabitView().environmentObject(habitList)
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
}

#Preview {
    ContentView()
        .environmentObject(TaskList())
        .environmentObject(HabitList())
}
