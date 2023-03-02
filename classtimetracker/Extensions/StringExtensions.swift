//
//  StringExtensions.swift
//  classtimetracker
//
//  Created by Sebastian on 02/03/2023.
//

import Foundation
import SwiftUI

extension String {
    func toColor() -> Color {
        switch self {
        case "blue"  : return Color.blue;
        case "green" : return Color.green;
        case "yellow": return Color.yellow;
        case "red"   : return Color.red;
        default: return Color(UIColor.label)
        }
    }
}
