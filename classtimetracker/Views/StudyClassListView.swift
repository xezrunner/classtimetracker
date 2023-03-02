//
//  StudyClassListView.swift
//  classtimetracker
//
//  Created by Sebastian on 02/03/2023.
//

import SwiftUI

struct StudyClassListView: View {
    @ObservedObject var viewModel = StudyClassViewModel()
    
    @State var infoTarget: StudyClass? = nil
    @State var showInfo = false
    
    func showStudyClassInfo(_ studyClass: StudyClass) -> () -> () {
        return {
            print("setting infoTarget to \(studyClass.name)")
            self.infoTarget = studyClass
            infoTarget = studyClass
            showInfo = true
        }
    }
    
    var body: some View {
        List() {
            ForEach(Array(viewModel.classes.enumerated()), id: \.offset) { index, element in
                HStack {
                    Image(systemName: element.icon).padding([.trailing], 8).foregroundColor(element.color.toColor())
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Class: ").foregroundColor(Color(UIColor.secondaryLabel))
                            Text(element.name).scaledToFit()
                        }
                        HStack {
                            Text("Duration: ").foregroundColor(Color(UIColor.secondaryLabel))
                            Text(element.duration.formatted())
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: showStudyClassInfo(element),  label: {
                            Image(systemName: "info.circle")
                        })
                        .buttonStyle(.bordered)
                        .sheet(isPresented: $showInfo) {
                        } content: {
                            StudyClassInfoSheetView(info: $infoTarget)
                        } .onDisappear(perform: {showInfo = false})
                        
                        Button(action: startLiveActivity(element),  label: {
                            Image(systemName: "play.circle")
                        })
                        .buttonStyle(.bordered)
                    }.foregroundColor(element.color.toColor())
                }.swipeActions {
                    Button(role: .destructive) {
                        viewModel.removeStudyClassAt(index)
                    } label: { Image(systemName: "trash") }
                }
            }
        }
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
                Text("ah f*ck")
            }
        }.padding().monospaced()
    }
}

struct StudyClassListView_Previews: PreviewProvider {
    static var previews: some View {
        StudyClassListView(viewModel: StudyClassViewModel(testClasses: StudyClass.defaultClasses))
    }
}
