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
    @State var currentAmount: Int = 0
    @State var totalAmount: Int = 1

    
    
    var body: some View {
        VStack {
            Spacer()
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
            
            Stepper(value: $currentAmount, in: 0...totalAmount) {
                Text("Current Amount (optional)")
                    .foregroundStyle(currentAmount == 0 ? .secondary : .primary)
                Text("\(currentAmount)")
                    .font(currentAmount == 0 ? .caption : .headline)
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            
            Stepper(value: $totalAmount, in: 1...100) {
                Text("Total Amount")
                Text("\(totalAmount)")
                    .font(.headline)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            // TODO: Make option for the M/W/F rather than over time period
            
            Picker(selection: $frequency, label: Text("Frequency")) {
                Text("Daily").tag(Frequency.daily)
                Text("Weekly").tag(Frequency.weekly)
                Text("Monthly").tag(Frequency.monthly)
                Text("Yearly").tag(Frequency.yearly)
            }
            .pickerStyle(.palette)
            .padding(.horizontal)
            .padding(.bottom, 30)
            
            
            Button(action: {
                let newHabit = Habit(name: name, description: description, frequency: frequency, totalAmount: totalAmount, currentAmount: currentAmount)
                
                habitList.addHabit(habit: newHabit)
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Add Habit")
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty)
            
            Spacer()
            
            Text(Habit(name: name, description: description, frequency: frequency, totalAmount: totalAmount, currentAmount: currentAmount).HabitPreviewString())
                .foregroundStyle(name == "" ? .color : .secondary)
                .font(.callout)
            Text(currentAmount == 0 ? "" : " (completed \(currentAmount) so far)")
                .foregroundStyle(name == "" ? .color : .secondary)
                .font(.caption)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    AddHabitView()
        .environmentObject(HabitList())
}
