//
//  ContentView.swift
//  classtimetracker
//
//  Created by Sebastian on 27/02/2023.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var showAddStudyClassSheet = false
    @State var showInfo  = false
    @State var infoTarget : StudyClass? = nil
    
    @ObservedObject var viewModel = StudyClassViewModel()
    
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
                
                Button() { showAddStudyClassSheet = true } label: {
                    Image(systemName: "plus.circle").frame(width: header_icon_width, height: header_icon_height)
                }
                .buttonStyle(.bordered)
                .sheet(isPresented: $showAddStudyClassSheet, onDismiss: {
                    showAddStudyClassSheet = false
                }) { AddStudyClassSheet(viewModel: viewModel, isSheetOpen: $showAddStudyClassSheet) }
            }
            .background(Color(UIColor.systemBackground))
            .padding(20)
            
            // TODO: separate either the list or the content into a custom View:
            StudyClassListView(viewModel: viewModel, infoTarget: infoTarget, showInfo: showInfo)
            
            HStack {
                Text("[debug]").foregroundColor(Color(UIColor.tertiaryLabel))
                Spacer()
            }.padding([.leading, .trailing])
            
            ScrollView (.horizontal) {
                HStack() {
                    Button(action: endAllLiveActivities) {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text("Cancel all live activities")
                        }
                    }.tint(Color(UIColor.systemOrange))
                    
                    Button() {
                        viewModel.classes.removeAll()
                        viewModel.encodeAndSave()
                    } label: {
                        HStack {
                            Image(systemName: "trash.circle")
                            Text("Remove all study classes")
                        }
                    }.tint(Color(UIColor.systemRed))
                    
                    Button() {
                        viewModel.classes = StudyClass.defaultClasses;
                        viewModel.encodeAndSave()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add test study classes")
                        }
                    }.tint(Color(UIColor.systemGreen))
                    
                }.buttonStyle(.bordered)
            }.padding()
            
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
