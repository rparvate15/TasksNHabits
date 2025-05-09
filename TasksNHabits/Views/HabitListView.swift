//
//  HabitListView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/9/25.
//

import SwiftUI

struct HabitListView: View {
    @EnvironmentObject var habitList: HabitList
    
    var body: some View {
        List {
            ForEach(habitList.habits, id: \.name) { eachHabit in
                Text(eachHabit.name)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    HabitListView()
        .environmentObject(HabitList())
}
