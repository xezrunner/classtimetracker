//
//  widgetextLiveActivity.swift
//  widgetext
//
//  Created by Sebastian on 27/02/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct widgetextAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct widgetextLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: StudyClassAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack() {
                Image(systemName: context.state.icon)
                VStack(alignment: .leading) {
                    Text(context.state.name)
                    Text("--:--")
                }
                Spacer()
            }.padding(25)
            .foregroundColor(Color.white)
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.white)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: context.state.icon).resizable().aspectRatio(contentMode: .fill).padding(20)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack(alignment: .leading) {
                        Text("\(context.state.name)")
                        Text("--:--")
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                    
                }
            } compactLeading: {
                Circle().frame(width: 15)
            } compactTrailing: {
                Text("--:--")
            } minimal: {
                Image(systemName: context.state.icon).padding()
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct widgetextLiveActivity_Previews: PreviewProvider {
    static let attributes = StudyClassAttributes()
    static let contentState = StudyClassAttributes.ContentState(name: "Test class", duration: .seconds(15), icon: "clock")

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
