//
//  ContentView.swift
//  classtimetracker
//
//  Created by Sebastian on 27/02/2023.
//

import SwiftUI
import ActivityKit

public var classes = [
    StudyClass(name: "Test study class #1"),
    StudyClass(name: "Test study class #2"),
    StudyClass(name: "Test study class #3")
]

struct ContentView: View {
    @State var showInfo  = false
    @State var infoTarget : StudyClass? = nil
    
    
    
    @ScaledMetric var header_icon_width : CGFloat = 20
    @ScaledMetric var header_icon_height: CGFloat = 20
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock").resizable().scaledToFit().frame(width: 25)
                    .padding([.trailing], 8)
                Text("Class tracker").font(.title)
                
                Spacer()
                
                Button() { } label: {
                    Image(systemName: "gear").frame(width: header_icon_width, height: header_icon_height)
                }
                .buttonStyle(.bordered)
                
                Button() { } label: {
                    Image(systemName: "plus.circle").frame(width: header_icon_width, height: header_icon_height)
                }
                .buttonStyle(.bordered)
            }
            .background(Color(UIColor.systemBackground))
            .padding(20)
            
            // TODO: separate either the list or the content into a custom View:
            StudyClassListView(classes: classes, infoTarget: infoTarget, showInfo: showInfo)
            
            Button(action: endAllLiveActivities) {
                HStack {
                    Image(systemName: "stop.circle")
                    Text("Cancel all live activities")
                }
            }
            .buttonStyle(.bordered)
            .tint(Color(UIColor.systemOrange))
            .padding()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
