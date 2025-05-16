//
//  HabitListView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/9/25.
//

import SwiftUI

struct HabitListView: View {
    @EnvironmentObject var habitList: HabitList
    @State private var habitToDelete: Habit?
    
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
                .transition(.opacity.combined(with: .move(edge: .trailing)))
                .swipeActions {
                    Button(role: .destructive) {
                        habitToDelete = habit
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .contextMenu {
                    Button(role: .destructive) {
                        habitToDelete = habit
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .confirmationDialog (
            "Delete Habit",
            isPresented: .constant(habitToDelete != nil),
            actions: {
                Button("Delete", role: .destructive) {
                    if let habit = habitToDelete {
                        withAnimation(.easeOut(duration: 0.2)) {
                            habitList.deleteHabit(id: habit.id)
                        }
                        habitToDelete = nil
                    }
                }
                Button("Cancel", role: .cancel) {
                    habitToDelete = nil
                }
            },
            message: {
                Text("Are you sure you want to delete \(habitToDelete?.name ?? "this habit?")?")
            }
        )
        .listStyle(.plain)
    }
}

#Preview {
    HabitListView()
        .environmentObject(HabitList())
}
