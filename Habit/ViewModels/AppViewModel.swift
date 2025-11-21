//
//  AppViewModel.swift
//  Habit
//
//  Created by Logan Cowley on 11/21/25.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject{
    @Published var tasks: [Task] = []
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
