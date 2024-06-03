//
//  TestWidgetLiveActivity.swift
//  TestWidget
//
//  Created by 석기권 on 6/3/24.
//

import ActivityKit
import WidgetKit
import SwiftUI



struct TestWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TestWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("My mood is \(context.state.mood.status) \(context.state.mood.emoji)")
                    .foregroundStyle(.white)
            }
            .activityBackgroundTint(.black)
            .opacity(0.5)
            
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
                    Text("Trailing")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("compactTrailing")
            } minimal: {
                Text("minimal")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TestWidgetAttributes {
    fileprivate static var preview: TestWidgetAttributes {
        TestWidgetAttributes(name: "World")
    }
}

extension TestWidgetAttributes.ContentState {
    fileprivate static var smiley: TestWidgetAttributes.ContentState {
        TestWidgetAttributes.ContentState(mood: MyMood(status: "happy", emoji: "😄"))
     }
     
     fileprivate static var starEyes: TestWidgetAttributes.ContentState {
         TestWidgetAttributes.ContentState(mood: MyMood(status: "happy", emoji: "😄"))
     }
}

//#Preview("Notification", as: .content, using: TestWidgetAttributes.preview) {
//   TestWidgetLiveActivity()
//} contentStates: {
//    TestWidgetAttributes.ContentState.smiley
//    TestWidgetAttributes.ContentState.starEyes
//}
