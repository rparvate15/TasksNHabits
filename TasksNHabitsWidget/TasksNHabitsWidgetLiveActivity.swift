//
//  TasksNHabitsWidgetLiveActivity.swift
//  TasksNHabitsWidget
//
//  Created by Rudra Parvate on 5/30/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TasksNHabitsWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TasksNHabitsWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TasksNHabitsWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TasksNHabitsWidgetAttributes {
    fileprivate static var preview: TasksNHabitsWidgetAttributes {
        TasksNHabitsWidgetAttributes(name: "World")
    }
}

extension TasksNHabitsWidgetAttributes.ContentState {
    fileprivate static var smiley: TasksNHabitsWidgetAttributes.ContentState {
        TasksNHabitsWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TasksNHabitsWidgetAttributes.ContentState {
         TasksNHabitsWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TasksNHabitsWidgetAttributes.preview) {
   TasksNHabitsWidgetLiveActivity()
} contentStates: {
    TasksNHabitsWidgetAttributes.ContentState.smiley
    TasksNHabitsWidgetAttributes.ContentState.starEyes
}
