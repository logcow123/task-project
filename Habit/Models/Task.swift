//
//  Task.swift
//  Habit
//
//  Created by Logan Cowley on 10/25/25.
//

import Foundation
import SwiftUI

struct Task: Identifiable{
    let id = UUID()
    var title: String
    var description: String
    var isComplete: Bool = false
    var theme: Theme = .gold
    var status: Status = .unmarked
    
    enum Status{
        case complete
        case missed
        case unmarked
    }
}

extension Task {
    var statusColor: Color {
        switch status {
        case .unmarked: return theme.accentColor
        case .complete: return .green
        case .missed: return .red
        }
    }
    var statusSymbol : Image {
        switch status {
        case .unmarked: return Image(systemName: "circle")
        case .complete: return Image(systemName: "checkmark.circle.fill")
        case .missed:   return Image(systemName: "xmark.circle.fill")
        }
    }
}

extension Task{
    static var exampleTask = Task(title: "Example Task", description: "This is an example task.")
}
