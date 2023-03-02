//
//  ContentView.swift
//  classtimetracker
//
//  Created by Sebastian on 27/02/2023.
//

import SwiftUI
import ActivityKit

struct StudyClass: Identifiable {
    public let id = UUID()
    
    let name: String
    let duration: Duration = .seconds((60 * 60) + (30 * 60))
    let color: Color = Color.blue
    let icon: String = "clock"
}

private var classes = [
    StudyClass(name: "Test study class #1"),
    StudyClass(name: "Test study class #2"),
    StudyClass(name: "Test study class #3")
]

struct ContentView: View {
    @State var showInfo  = false
    @State var infoTarget : StudyClass? = nil
    
    func showStudyClassInfo(_ studyClass: StudyClass) -> () -> () {
        return {
            print("setting infoTarget to \(studyClass.name)")
            self.infoTarget = studyClass
            infoTarget = studyClass
            showInfo = true
        }
    }
    
    @State var activity : Activity<StudyClassAttributes>?
    
    func startLiveActivity(_ studyClass: StudyClass) -> () -> () {
        return {
            print("requesting live activity for \(studyClass.name)...")
            
            if !ActivityAuthorizationInfo().areActivitiesEnabled {
                print("Live activities unavailable.")
            }
            
            let initialContentState = StudyClassAttributes.ContentState(name: studyClass.name, duration: studyClass.duration, icon: studyClass.icon)
            let activityAttributes = StudyClassAttributes()
            
            let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: 5, to: Date())!)
            
            do {
                activity = try Activity.request(attributes: activityAttributes, content: activityContent)
            } catch (let error) {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func endAllLiveActivities() {
        Task {
            for it in Activity<StudyClassAttributes>.activities {
                await it.end(nil, dismissalPolicy: .immediate)
            }
            
        }
    }
    
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
            
            List(classes) { c in
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Class: ").foregroundColor(Color(UIColor.secondaryLabel))
                            Text(c.name).scaledToFit()
                        }
                        HStack {
                            Text("Duration: ").foregroundColor(Color(UIColor.secondaryLabel))
                            Text(c.duration.formatted())
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: showStudyClassInfo(c),  label: {
                        Image(systemName: "info.circle")
                    })
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $showInfo) {
                    } content: {
                        StudyClassInfoSheetView(info: $infoTarget)
                    } .onDisappear(perform: {showInfo = false})
                    
                    Button(action: startLiveActivity(c),  label: {
                        Image(systemName: "play.circle")
                    })
                    .buttonStyle(.bordered)
                }.swipeActions {
                    Button(role: .destructive) { } label: { Image(systemName: "trash") }
                }
            }
            
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
    
    struct StudyClassInfoSheetView: View {
        @Binding var info: StudyClass?
        
        var body: some View {
            VStack(alignment: .leading) {
                if let uw = info {
                    Text("id:       \(uw.id)").scaledToFit()
                    Text("name:     \(uw.name)")
                    Text("duration: \(uw.duration.formatted())")
                    Text("color:    \(uw.color.description)")
                    HStack {
                        Text("icon:     \(uw.icon)")
                        Image(systemName: uw.icon)
                    }
                } else {
                    Text("ah fuck")
                }
            }.padding().monospaced()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
