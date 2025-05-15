//
//  HabitDetailsPreview.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/15/25.
//

import SwiftUI

struct HabitDetailsPreview: View {
    let habit: Habit
    @EnvironmentObject var habitList: HabitList
    
    var body: some View {
        HabitDetailsView(habit: habit)
            .environmentObject(habitList)
            .frame(width: 300, height: 600)
            .background(.thinMaterial)
    }
}

#Preview {
    HabitDetailsPreview(habit: Habit(
        name: "Test Habit",
        description: "This is a test habit",
        frequency: .daily,
        totalAmount: 83,
        currentAmount: 0
    ))
        .environmentObject(HabitList())
}
