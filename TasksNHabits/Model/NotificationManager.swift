//
//  NotificationManager.swift
//  TasksNHabits
//
//  Created by Rudra Parvate on 5/30/25.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager() // Singleton
    
    private init() {}
    
    // Request user permission
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted ✅")
            }
        }
    }
    
    // Schedule a notification for a task
    func scheduleNotification(for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "Task Due Soon: \(task.name)"
        content.body = "Due at \(task.completeDate.formatted())!"
        content.sound = .default
        
        let triggerDate = Calendar.current.date(byAdding: .minute, value: -15, to: task.completeDate)!
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate),
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: task.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Cancel a notification for a task
    func cancelNotification(for task: Task) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
    }
    
    // Schedule habit reset notification
       func scheduleHabitResetNotification(for habit: Habit) {
           let content = UNMutableNotificationContent()
           content.title = "Habit Reset: \(habit.name)"
           content.body = "Your \(habit.name) habit has been reset for the new \(habit.frequency.rawValue)"
           content.sound = .default
           
           let nextReset = habit.nextResetDate()
           let triggerDate = Calendar.current.dateComponents(
               [.year, .month, .day, .hour, .minute, .second],
               from: nextReset
           )
           
           let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
           let request = UNNotificationRequest(
               identifier: habit.id.uuidString,
               content: content,
               trigger: trigger
           )
           
           UNUserNotificationCenter.current().add(request)
       }
       
       // Cancel notification when habit is deleted
       func cancelNotification(for habitId: UUID) {
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [habitId.uuidString])
       }
    
}
