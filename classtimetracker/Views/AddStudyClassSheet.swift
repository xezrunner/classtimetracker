//
//  AddStudyClassSheet.swift
//  classtimetracker
//
//  Created by Sebastian on 02/03/2023.
//

import SwiftUI

struct AddStudyClassSheet: View {
    @ObservedObject var viewModel = StudyClassViewModel()
    @Binding var isSheetOpen: Bool
    
    @State var className = "Class name"
    @State var classDuration = "5400"
    @State var classColor = "blue"
    
    @State var addResult = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Add class").font(.title)
            
            Grid(alignment: .leading) {
                GridRow() {
                    Text("Class name: ")
                    TextField("Class name", text: $className).textFieldStyle(.roundedBorder)
                }
                GridRow() {
                    Text("Duration: ")
                    TextField("Duration (in seconds)", text: $classDuration).textFieldStyle(.roundedBorder)
                }
                GridRow() {
                    Text("Color: ")
                    TextField("Color", text: $classColor).textFieldStyle(.roundedBorder)
                }
                // TODO: icon
            }
            
            HStack {
                Spacer()
                VStack {
                    if !addResult {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                            Text("Uh-oh! Something went wrong.")
                        }.foregroundColor(Color(UIColor.systemRed)).padding([.bottom])
                    }
                    
                    Button() {
                        let newClass = StudyClass(className, .seconds(Double(classDuration) ?? 5400), classColor, "clock")
                        addResult = viewModel.addStudyClass(newClass)
                        if addResult { isSheetOpen = false } // This is a binding to ContentView, thus will dismiss the sheet.
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add to list")
                        }
                    }.buttonStyle(.borderedProminent)
                }
                    
                Spacer()
            }.padding()
            
            
        }.padding(30)
    }
}

struct AddStudyClassSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddStudyClassSheet(isSheetOpen: .constant(true))
    }
}
