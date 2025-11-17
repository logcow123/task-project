//
//  TaskViewModel.swift
//  Habit
//
//  Created by Logan Cowley on 10/25/25.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = TaskViewModel.sampleTasks // Change Later
    
    func addTask(title: String, description: String) {
        guard !title.isEmpty else { return }
        let newTask = Task(title: title, description: description)
        tasks.append(newTask)
    }
    func addTask(task: Task) {
        tasks.append(task)
    }
    
    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isComplete.toggle()
            tasks[index].theme = (tasks[index].isComplete ? .main : .gold)
        }
    }
    func markTaskAsComplete(for task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id}) {
            tasks[index].isComplete = true
            tasks[index].status = .complete
            tasks[index].theme = .main
        }
    }
    func markTaskAsMissed(for task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id}) {
            tasks[index].isComplete = true
            tasks[index].status = .missed
            tasks[index].theme = .main
        }
    }
    func markTaskAsIncomplete(for task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id})
            {
            tasks[index].isComplete = false
            tasks[index].status = .unmarked
            tasks[index].theme = .gold
        }
    }
    
    func changeTaskTitle(for task: Task, to newTitle: String) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = newTitle
        }
    }
    func changeTaskDescription(for task: Task, to newDescritpion: String){
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].description = newDescritpion
        }
    }
}

