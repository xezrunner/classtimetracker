//
//  StudyClassAttribute.swift
//  classtimetracker
//
//  Created by Sebastian on 27/02/2023.
//

import Foundation
import ActivityKit

struct StudyClassAttributes: ActivityAttributes {
    public typealias StudyClassStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var name: String
        var duration: Duration
        var icon: String
    }
    
}
