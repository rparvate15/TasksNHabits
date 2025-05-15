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
                    .italic()
            }
            else {
                Text("Empty description")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .italic()
                    .opacity(0.3)
            }
            
            
            VStack {
                Text("Total Amount : \(habit.totalAmount)")
                    .font(.title2)
                    .foregroundStyle(.purple)
                    .padding(.top, 50)
                    .padding(.bottom, 5)
                Text("Current Amount : \(habit.currentAmount)")
                    .font(.title3)
                    .foregroundStyle(.purple)
                    .opacity(habit.currentAmount > 0 ? 1 : 0.7)
            }
            .padding(.bottom, 20)
            
            
            VStack(spacing: 8) {
                Button {
                    // Add one to habit current amount
                } label: {
                    Image(systemName: "chevron.up")
                }
                .disabled(habit.currentAmount >= habit.totalAmount)
                .font(.largeTitle)
                
                Button {
                    // Subtract one from habit current amount
                } label: {
                    Image(systemName: "chevron.down")
                }
                .disabled(habit.currentAmount <= 0)
                .font(.largeTitle)
            }
            .buttonStyle(.bordered)
            .tint(.purple)
            
            //TODO: Add Plus/Minus buttons
            .padding(.bottom, 50)
            
            if habit.currentAmount == habit.totalAmount {
                Text("Congratulations! You have completed your habit!")
                    .font(.headline)
                    .foregroundStyle(.purple)
                    .italic()
            }
            else {
                Text("You have \(habit.TimeUntil()) until your next habit deadline!")
                    .padding()
                    .foregroundStyle(.purple)
                    .font(.callout)
                    .bold()
                    .italic()
                    .multilineTextAlignment(.center)
            }
            
            
            Spacer()
        }
    }
}

#Preview {
    HabitDetailsView(habit: Habit(name: "Name of Habit", description: "Description", frequency: .yearly, totalAmount: 3, currentAmount: 0))
}
