//
//  Theme.swift
//  Habit
//
//  Created by Logan Cowley on 10/30/25.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable{
    
    case main
    case gold
    case green
    case slate
    
    public var accentColor: Color {
        switch self {
        case .gold, .green, .slate: return .black
        case .main: return .white
        }
    }
    public var mainColor: Color {
        Color(rawValue)
    }
    public var name: String {
        rawValue.capitalized
    }
    public var id: String {
        name
    }
}
