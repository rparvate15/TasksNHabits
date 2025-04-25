//
//  AddTaskView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 3/28/25.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskList: TaskList
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    
    var body: some View {
        VStack {
            Text("Add Task")
                .font(.title)
                .foregroundStyle(.purple)
                .padding(.bottom, 30)
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Cancel", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                        .opacity(0.8)
                }
                .padding(.leading, 20)
                Spacer()
            }
            TextField("Task Name (Required)", text: $name)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundStyle(.purple)
            
            TextField("Description (Optional)", text: $description, axis: .vertical)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundStyle(.purple)
            
            DatePicker(selection: $dueDate, label: { Text("Due Date") })
                .padding()
                .padding(.bottom, 40)
            
            
            Button(action: {
                let newTask = Task(name: name, description: description, completeDate: dueDate)
                taskList.addTask(task: newTask)
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Add Task")
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    AddTaskView()
        .environmentObject(TaskList())
}
