//
//  ProgressCircle.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/15/25.
//

import SwiftUI
import Foundation

struct ProgressCircle: View {
    var habit: Habit
    var lineWidth: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle (
                    lineWidth: lineWidth,
                    lineCap: .round,
                    lineJoin: .round
                    )
                )
                .foregroundStyle(.gray)
                .opacity(0.2)
            
            Circle()
                .trim(from: 0, to: CGFloat(habit.currentAmount) / CGFloat(habit.totalAmount))
                .stroke(style: StrokeStyle (
                    lineWidth: lineWidth,
                    lineCap: .round,
                    lineJoin: .round
                    )
                )
                .foregroundStyle(.purple)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.3), value: habit.currentAmount)
        }   
    }
}

#Preview {
    ProgressCircle(habit: Habit(
        name: "Test Habit",
        description: "Description",
        frequency: .daily,
        totalAmount: 5,
        currentAmount: 2
    ), lineWidth: 10)
}
