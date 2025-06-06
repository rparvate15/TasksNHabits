//
//  HabitDetailsView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/9/25.
//

import SwiftUI

struct HabitDetailsView: View {
    var habit: Habit
    @EnvironmentObject var habitList: HabitList
    @Environment(\.dismiss) var dismiss
    @State private var dueDate: Date = Date()
    @State private var currentDate = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
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
                    habitList.incrementHabit(id: habit.id)
                } label: {
                    Image(systemName: "chevron.up")
                }
                .disabled(habit.currentAmount >= habit.totalAmount)
                .font(.largeTitle)
                
                Button {
                    // Subtract one from habit current amount
                    habitList.decrementHabit(id: habit.id)
                } label: {
                    Image(systemName: "chevron.down")
                }
                .disabled(habit.currentAmount <= 0)
                .font(.largeTitle)
            }
            .buttonStyle(.bordered)
            .tint(.purple)
            
            ProgressCircle(habit: habit, lineWidth: 15)
                .frame(width: 80, height: 80)
                .padding(.top, 25)
            
            Spacer()
            
            if habit.currentAmount == habit.totalAmount {
                Text("Congratulations!\nYou have completed your habit!")
                    .font(.headline)
                    .foregroundStyle(.purple)
                    .italic()
                    .multilineTextAlignment(.center)
            }
            else {
                Text("You have \(habit.TimeUntil(currentDate: currentDate)) until your next habit deadline!")
                    .onReceive(timer) { _ in
                        currentDate = Date()
                    }
                    .padding(.horizontal)
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
    HabitDetailsView(habit: Habit(name: "Name of Habit", description: "Description", frequency: .yearly, totalAmount: 3, currentAmount: 2))
        .environmentObject(HabitList())
}
