//
//  TaskView.swift
//  Habit
//
//  Created by Logan Cowley on 10/27/25.
//

import SwiftUI

struct TaskCardView: View {
    @StateObject var viewModel: TaskViewModel
    var taskId: UUID
    var body: some View {
        if let task = viewModel.tasks.first(where: {$0.id == taskId}){
            HStack {
                VStack(alignment: .leading){
                    Text(task.title)
                        .font(.headline)
                    if !task.description.isEmpty{
                        Text(task.description)
                            .lineLimit(2)
                            .truncationMode(.tail)
                    }
                }
                .padding()
                .foregroundColor(task.theme.accentColor)
                Spacer()
                Menu{
                    Button(action:{
                        viewModel.markTaskAsComplete(for: task)
                    }){
                        Text("Task Complete")
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                    Button(action:{
                        viewModel.markTaskAsMissed(for: task)
                    }){
                        Text("Task Missed")
                        Image(systemName: "x.circle")
                            .foregroundColor(.red)
                    }
                    Button(action: {
                        viewModel.markTaskAsIncomplete(for: task)
                    }){
                        Text("Task Incomplete")
                        Image(systemName: "circle")
                    }
                }label: {
                    task.statusSymbol
                        .font(.largeTitle)
                        .shadow(
                            color: .black,
                            radius: task.isComplete ? 2: 0)
                }
                .foregroundColor(task.statusColor)
                .padding()
                
            }.background(task.theme.mainColor)
             .cornerRadius(12)
             .padding(.top, 2)
             .padding(.horizontal, 8)
        }
    }
}

#Preview (traits: .fixedLayout(width: 400, height: 60)){
    let viewModel = TaskViewModel()
    let task = viewModel.tasks.first!
    TaskCardView(viewModel: viewModel, taskId: task.id)
}

