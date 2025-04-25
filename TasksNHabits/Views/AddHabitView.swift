//
//  AddHabitView.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 4/25/25.
//

import SwiftUI

struct AddHabitView: View {
    @EnvironmentObject var habitList: HabitList
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State var frequency: Frequency = .daily
    @State var totalAmount: Int = 0
    @State var currentAmount: Int = 0
    @State private var isCompleted: Bool = false

    
    
    var body: some View {
        VStack {
            Text("Add New Habit")
                .font(.title)
                .foregroundStyle(.purple)
                .padding(.bottom, 30)
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("Cancel", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                        .opacity(0.8)
                }
                .padding(.leading, 20)
                Spacer()
            }
            TextField("Habit Title (Required)", text: $name)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundStyle(.purple)
            
            TextField("Description (Optional)", text: $description, axis: .vertical)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundStyle(.purple)
            
//          TODO: Picker for the total amount
            
//          TODO: Picker for the current amount (optional)
            
//          TODO: Enum picker for the frequency
            
            
            Button(action: {
                let newHabit = Habit(name: name, description: description, frequency: frequency, totalAmount: totalAmount, currentAmount: currentAmount, isCompleted: isCompleted)
                
                habitList.addHabit(habit: newHabit)
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Add Habit")
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    AddHabitView()
        .environmentObject(HabitList())
}
