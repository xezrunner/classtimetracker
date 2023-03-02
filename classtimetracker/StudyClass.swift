//
//  StudyClass.swift
//  classtimetracker
//
//  Created by Sebastian on 02/03/2023.
//

import Foundation
import SwiftUI

public struct StudyClass: Codable {
    static var defaultClasses = [
        StudyClass("Test class #1", .seconds(5400), "blue", "clock"),
        StudyClass("Test class #2", .seconds(5400), "green", "cube"),
    ]
    
    init(_ name: String, _ duration: Duration = .seconds(5400), _ color: String = "blue", _ icon: String = "clock") {
        self.name = name
        self.duration = duration
        self.color = color
        self.icon = icon
    }
    
    let name: String
    let duration: Duration
    let color: String
    let icon: String
    
    static func encodeClassesToData(_ object: [StudyClass]) -> Data {
        guard let encoded = try? JSONEncoder().encode(object) else { return Data() }
        return encoded
    }
    
    static func decodeClassesFromData(_ data: Data) -> [StudyClass] {
        guard let decoded = try? JSONDecoder().decode([StudyClass].self, from: data) else { return [] }
        return decoded
    }
}

class StudyClassViewModel: ObservableObject {
    init() {
        classes = StudyClass.decodeClassesFromData(UserDefaults.standard.data(forKey: "classes") ?? Data())
    }
    init(testClasses: [StudyClass]) {
        classes = testClasses
    }
    
    @Published var classes : [StudyClass] = []
    
    func encodeAndSave() {
        let encoded = StudyClass.encodeClassesToData(classes)
        UserDefaults.standard.set(encoded, forKey: "classes")
    }
    
    func addStudyClass(_ newClass: StudyClass) -> Bool {
        classes.append(newClass)
        encodeAndSave()
        return true
    }
    
    func removeStudyClassAt(_ index: Int) {
        classes.remove(at: index)
        encodeAndSave()
    }
}

extension StudyClass: Identifiable {
    public var id: UUID { return UUID() }
}
