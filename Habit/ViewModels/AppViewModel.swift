//
//  AppViewModel.swift
//  Habit
//
//  Created by Logan Cowley on 11/21/25.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject{
    @Published var tasks: [Task] = exampleTasks
    @Published var selectedDate: Date = Date()
    @Published var selectedID: UUID? {
            didSet {
                if let id = selectedID, index(for: id) == nil {
                    selectedID = nil
                }
            }
        }
    
    var tasksForDate: [Task] {
        tasks
            .filter { Calendar.current.isDate($0.startTime, inSameDayAs: selectedDate) }
            .sorted { $0.startTime < $1.startTime }
    }
    
    var selectedTask: Task? {
            selectedID.flatMap { task(id: $0) }
        }
    
    var selectedTaskBinding: Binding<Task>? {
        guard let id = selectedID,
              let index = index(for: id) else { return nil }

        return Binding(
            get: { self.tasks[index] },
            set: { self.tasks[index] = $0 }
        )
    }
    
    func addTask(task: Task){
        tasks.append(task)
    }
    func deleteTask(id: UUID){
        tasks.removeAll { $0.id == id }
        if selectedID == id { selectedID = nil }
    }
    
    // This is a powerful function that can mutate the Tasks in the list without needing to index them each time
    func update(_ id: UUID, _ mutate: (inout Task) -> Void) {
            guard let index = index(for: id) else { return }
            mutate(&tasks[index])
        }
    
    func task(id: UUID) -> Task? {
        tasks.first(where: { $0.id == id })
    }
    
    // example of using the new update function to set the status
    func updateStatus(id: UUID, to status: Task.Status) {
            update(id) { $0.setStatus(status) }
        }
    
    private func index(for id: UUID) -> Int? {
        tasks.firstIndex(where: { $0.id == id })
    }
}

extension AppViewModel{
    static let exampleTasks: [Task] = [
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
                ),
            Task(title: "Eat breakfast",
                 description: "Go and Eat Breakfast",
                 startTime: .from("2025-11-22 7:30"),
                 endTime: .from("2025-11-22 8:00")
                ),
            Task(title: "Read a Book!",
                 description: "I want to read a book",
                 startTime: .from("2025-11-22 8:30"),
                 endTime: .from("2025-11-22 11:30")
                ),
            Task(title: "Work on Project",
                 description: "Develop my Million Dollar app",
                 startTime: .from("2025-11-22 12:00"),
                 endTime: .from("2025-11-22 19:00")
                ),
            Task(title: "Eat a Burger",
                 description: "Forget the kids, Eat a burger!",
                 startTime: .from("2025-11-22 15:30"),
                 endTime: .from("2025-11-22 15:45")
                )
    ]
}
