//
//  Task.swift
//  Habit
//
//  Created by Logan Cowley on 10/25/25.
//

import Foundation
import SwiftUI

struct Task: Identifiable, Hashable{
    let id = UUID()
    var title: String
    var description: String
    var isComplete: Bool = false
    var theme: Theme = .gold
    var status: Status = .unmarked
    var startTime: Date = Date()
    var endTime: Date = Date()
    
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
    static let mockTasks = [
        Task(title: "Eat breakfast",
             description: "Go and Eat Breakfast",
             startTime: .from("2025-11-17 7:30"),
             endTime: .from("2025-11-17 8:00")
            ),
        Task(title: "Go on Jog",
             description: "Jog around the Block",
             startTime: .from("2025-11-17 8:30"),
             endTime: .from("2025-11-17 9:30")
            ),
        Task(title: "Work on Project",
             description: "Develop my Million Dollar app",
             startTime: .from("2025-11-17 10:00"),
             endTime: .from("2025-11-17 17:00")
            ),
        Task(title: "Pick up Kids",
             description: "Don't forget to pick up the kids!",
             startTime: .from("2025-11-17 15:30"),
             endTime: .from("2025-11-17 15:45")
            )
    ]
}
extension Date {

  /// Creates a `Date` object from the given string representation.
  ///
  /// - Parameters:
  ///   - dateString: The string representing the date.
  ///   - format: The format of the date string. Default is "yyyy-MM-dd HH:mm".
  /// - Returns: A `Date` object created from the string representation.
  static func from(_ dateString: String, format: String = "yyyy-MM-dd HH:mm") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: dateString)!
  }
}
