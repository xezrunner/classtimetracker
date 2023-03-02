//
//  classtimetrackerApp.swift
//  classtimetracker
//
//  Created by Sebastian on 27/02/2023.
//

import SwiftUI

@main
struct classtimetrackerApp: App {
    var defaultClasses = [
        StudyClass("test1"),
        StudyClass("test2"),
        StudyClass("test3")
    ]
    
    init() {
        UserDefaults.standard.register(defaults: [
            "classes": StudyClass.encodeClassesToData(defaultClasses)
        ])
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
