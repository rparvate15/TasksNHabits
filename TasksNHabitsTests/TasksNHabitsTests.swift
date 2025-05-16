//
//  TasksNHabitsTests.swift
//  TasksNHabitsTests
//
//  Created by Rudra Parvate on 3/27/25.
//

import Testing
import Foundation
@testable import TasksNHabits

struct TasksNHabitsTests {
    
    // MARK: - Habit Tests
    @Test func testHabitInitialization() {
        let habit = Habit(
            name: "Exercise",
            description: "Daily workout",
            frequency: .daily,
            totalAmount: 1,
            currentAmount: 0
        )
        
        #expect(habit.name == "Exercise")
        #expect(habit.description == "Daily workout")
        #expect(habit.frequency == .daily)
        #expect(habit.totalAmount == 1)
        #expect(habit.currentAmount == 0)
    }
    
    @Test func testHabitPreviewString() {
        let dailyHabit = Habit(
            name: "Meditate",
            description: "Mindfulness practice",
            frequency: .daily,
            totalAmount: 2,
            currentAmount: 1
        )
        
        #expect(dailyHabit.HabitPreviewString() == "Meditate 2 times a day")
    }
    
    @Test func testTimeUntilFormats() {
        let frequencies: [Frequency] = [.daily, .weekly, .monthly, .yearly]
        
        for frequency in frequencies {
            let habit = Habit(
                name: "Test",
                description: "Test",
                frequency: frequency,
                totalAmount: 1,
                currentAmount: 0
            )
            let timeString = habit.TimeUntil()
            #expect(!timeString.isEmpty, "Empty string for \(frequency.rawValue) frequency")
        }
    }
    
    // MARK: - HabitList Tests
    @Test func testHabitListCRUD() {
        let habitList = HabitList()
        let testHabit = Habit(name: "Test Habit", description: "Test", frequency: .daily, totalAmount: 1, currentAmount: 0)
        
        // Test Add
        habitList.addHabit(habit: testHabit)
        #expect(habitList.habits.contains(where: { $0.id == testHabit.id }))
        
        // Test Increment
        habitList.incrementHabit(id: testHabit.id)
        #expect(habitList.habits.first(where: { $0.id == testHabit.id })?.currentAmount == 1)
        
        // Test Decrement
        habitList.decrementHabit(id: testHabit.id)
        #expect(habitList.habits.first(where: { $0.id == testHabit.id })?.currentAmount == 0)
        
        // Test Delete
        habitList.deleteHabit(id: testHabit.id)
        #expect(!habitList.habits.contains(where: { $0.id == testHabit.id }))
    }
    
    @Test func testHabitPersistence() {
        let initialList = HabitList()
        let testHabit = Habit(name: "Persistent", description: "Test", frequency: .weekly, totalAmount: 3, currentAmount: 1)
        
        initialList.addHabit(habit: testHabit)
        
        let loadedList = HabitList()
        #expect(loadedList.habits.contains(where: { $0.id == testHabit.id }))
        
        // Cleanup
        initialList.deleteHabit(id: testHabit.id)
    }
    
    // MARK: - Task Tests
    @Test func testTaskInitialization() {
        let task = Task(
            name: "Buy groceries",
            description: "Weekly shopping",
            completeDate: Date().addingTimeInterval(86400)
        )
        
        #expect(task.name == "Buy groceries")
        #expect(task.description == "Weekly shopping")
        #expect(task.isCompleted == false)
    }
    
    @Test func testTaskTimeUntil() {
        let futureDate = Date().addingTimeInterval(90000) // 25 hours
        let task = Task(name: "Test", completeDate: futureDate)
        let timeString = task.timeUntil()
        #expect(timeString.contains("days") || timeString.contains("hours"))
    }
    
    @Test func testDateFormatters() {
        let date = Date()
        let task = Task(name: "Test", completeDate: date)
        
        #expect(!task.dateToString().isEmpty)
        #expect(!task.timeToString().isEmpty)
    }
    
    // MARK: - TaskList Tests
    @Test func testTaskListCRUD() {
        let taskList = TaskList()
        let testTask = Task(name: "Test Task")
        
        // Test Add
        taskList.addTask(task: testTask)
        #expect(taskList.tasks.contains(where: { $0.id == testTask.id }))
        
        // Test Toggle
        taskList.toggleTaskCompletion(id: testTask.id)
        #expect(taskList.tasks.first(where: { $0.id == testTask.id })?.isCompleted == true)
        
        // Test Delete
        taskList.deleteTask(id: testTask.id)
        #expect(!taskList.tasks.contains(where: { $0.id == testTask.id }))
    }
    
    @Test func testTaskPersistence() {
        let initialList = TaskList()
        let testTask = Task(name: "Persistent Task")
        
        initialList.addTask(task: testTask)
        
        let loadedList = TaskList()
        #expect(loadedList.tasks.contains(where: { $0.id == testTask.id }))
        
        // Cleanup
        initialList.deleteTask(id: testTask.id)
    }
    
    // MARK: - FileManager Extension Test
    @Test func testDocumentsDirectory() {
        let docsDir = FileManager.documentsDirectory
        #expect(docsDir.isFileURL)
        #expect(docsDir.lastPathComponent == "Documents")
    }
}
