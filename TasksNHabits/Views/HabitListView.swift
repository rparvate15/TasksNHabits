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
                NavigationLink(destination: HabitDetailsView(habit: habit).environmentObject(habitList)) {
                        
                        HStack {
                            Text(habit.name)
                                .foregroundStyle(.purple)
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Button {
                                    habitList.incrementHabit(id: habit.id)
                                } label: {
                                    Image(systemName: "chevron.up")
                                }
                                .disabled(habit.currentAmount >= habit.totalAmount)
                                
                                Button {
                                    habitList.decrementHabit(id: habit.id)
                                } label: {
                                    Image(systemName: "chevron.down")
                                }
                                .disabled(habit.currentAmount <= 0)
                            }
                            .buttonStyle(.bordered)
                            .tint(.purple)
                            
                            Spacer()
                            
                            Text("\(habit.currentAmount) / \(habit.totalAmount)")
                                .foregroundStyle(.purple)
                            
                            ProgressCircle(habit: habit, lineWidth: 2)
                                .fixedSize()
                            

                            
                            Text("\(habit.frequency)")
                                .font(.callout)
                                .foregroundStyle(.gray)
                                .fixedSize()
                            
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
