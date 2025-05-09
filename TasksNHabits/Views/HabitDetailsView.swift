//
//  HabitDetailsView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/9/25.
//

import SwiftUI

struct HabitDetailsView: View {
    var habit: Habit
    @Environment(\.dismiss) var dismiss
    @State private var dueDate: Date = Date()
    
    var body: some View {
        VStack {
            Spacer()
            Text(habit.name)
                .font(.title)
                .foregroundStyle(.purple)
                .padding(.vertical)
            if !habit.description.isEmpty {
                Text(habit.description)
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
                Text("SpaceHolder")
                    .font(.title2)
                    .foregroundStyle(.purple)
                    .padding(.top, 50)
                Text("SpaceHolder")
                    .font(.title2)
                    .foregroundStyle(.purple)
            }
            
            
            Spacer()
            
            
            
            Spacer()
        }
    }
}

#Preview {
    HabitDetailsView(habit: Habit(name: "Test", description: "Test", frequency: .daily, totalAmount: 1, currentAmount: 0, isCompleted: false))
}
