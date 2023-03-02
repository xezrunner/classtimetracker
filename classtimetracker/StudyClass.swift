//
//  StudyClass.swift
//  classtimetracker
//
//  Created by Sebastian on 02/03/2023.
//

import Foundation
import SwiftUI

public struct StudyClass: Codable {
    init(_ name: String) {
        self.name = name
        self.duration = .seconds(2 * (60 * 1000) + (30 * 1000)) // TODO: this might not be correct
        self.color = "blue"
        self.icon = "clock"
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

extension StudyClass: Identifiable {
    public var id: UUID { return UUID() }
}
