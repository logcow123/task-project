//
//  TaskViewModel+Content.swift
//  Habit
//
//  Created by Logan Cowley on 11/1/25.
//

import SwiftUI

extension TaskViewModel {
    static let sampleTasks: [Task] = [
        Task(title: "Bake Cookies",
             description: "Gather ingredients and bake cookies!"),
        Task(title: "Test Task 2",
             description: "This is my second test task. It should be longer than the first one to test the dynamic height of the task view"),
        Task(title: "Eat More Vegitables!",
             description: "I need to maintain a healthy diet and Eat Vegitables"),
        Task(title: "One Line Task",
             description: "One Line")
    ]
}
