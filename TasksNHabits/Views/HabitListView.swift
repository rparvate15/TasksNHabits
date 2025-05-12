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
                                .foregroundStyle(.purple)
                            Spacer()
                            Text("\(habit.currentAmount) / \(habit.totalAmount)")
                                .foregroundStyle(.purple)
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 2)
                                    .foregroundStyle(.gray)
                                    .opacity(0.2)
                                    .fixedSize()
                                
                                Circle()
                                    .trim(from: 0, to: CGFloat(habit.currentAmount) / CGFloat(habit.totalAmount))
                                    .stroke(lineWidth: 2)
                                    .foregroundStyle(.purple)
                                    .fixedSize()
                                    .rotationEffect(.degrees(-90))
                                
                            }
                            
                            Text("\(habit.frequency)")
                                .font(.callout)
                                .foregroundStyle(.gray)
                            
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
