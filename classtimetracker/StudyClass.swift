//
//  StudyClass.swift
//  classtimetracker
//
//  Created by Sebastian on 02/03/2023.
//

import Foundation
import SwiftUI

public struct StudyClass: Identifiable {
    public let id = UUID()
    
    let name: String
    let duration: Duration = .seconds((60 * 60) + (30 * 60))
    let color: Color = Color.blue
    let icon: String = "clock"
}
