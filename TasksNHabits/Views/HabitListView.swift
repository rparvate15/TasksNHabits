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
            ForEach(habitList.habits, id: \.id) { habit in
                NavigationLink(destination: HabitDetailsView(habit: habit)) {
                    HStack {
                        Text(habit.name)
                        Spacer()
                        Text("\(habit.currentAmount) / \(habit.totalAmount)")
                        
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        habitList.deleteHabit(id: habit.id)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    HabitListView()
        .environmentObject(HabitList())
}
