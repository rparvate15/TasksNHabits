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
                            
                            ZStack {
                                Circle()
                                    .stroke(style: StrokeStyle (
                                        lineWidth: 2,
                                        lineCap: .round,
                                        lineJoin: .round
                                        )
                                    )
                                    .foregroundStyle(.gray)
                                    .opacity(0.2)
                                    .fixedSize()
                                
                                Circle()
                                    .trim(from: 0, to: CGFloat(habit.currentAmount) / CGFloat(habit.totalAmount))
                                    .stroke(stroke(style: StrokeStyle (
                                        lineWidth: 2,
                                        lineCap: .round,
                                        lineJoin: .round
                                    )
                            ))
                                    .foregroundStyle(.purple)
                                    .fixedSize()
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut(.duration(0.3)), value: habit.currentAmount)
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
