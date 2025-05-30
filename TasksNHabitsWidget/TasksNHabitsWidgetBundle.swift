//
//  TasksNHabitsWidgetBundle.swift
//  TasksNHabitsWidget
//
//  Created by Rudra Parvate on 5/30/25.
//

import WidgetKit
import SwiftUI

@main
struct TasksNHabitsWidgetBundle: WidgetBundle {
    var body: some Widget {
        TasksNHabitsWidget()
        TasksNHabitsWidgetControl()
        TasksNHabitsWidgetLiveActivity()
    }
}
