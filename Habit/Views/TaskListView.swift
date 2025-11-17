//
//  TaskView.swift
//  Habit
//
//  Created by Logan Cowley on 10/25/25.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskViewModel()
    @State var hasPopup: Popup = .noPopup
    
    var body: some View {
        ZStack {
            VStack {
                Text("Tasks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                ScrollView {
                    VStack(alignment: .leading){
                        ForEach(viewModel.tasks){ task in
                            TaskCardView(viewModel: viewModel, taskId: task.id)
                                .onTapGesture {
                                    viewModel.currentId = task.id
                                    hasPopup = .detailTask
                                }
                        }.navigationTitle(Text("Tasks"))
                    }
                }
                Button(action: {
                    hasPopup = .addTask
                }, label: {
                    Text("Add Task")
                }).padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            switch hasPopup {
                case .noPopup:
                    EmptyView()
                case .addTask:
                    PopupView(content: TaskAddView(viewModel: viewModel, isPresented: $hasPopup))
                case .detailTask:
                if let task = viewModel.selectedTaskBinding{
                        PopupView(content: TaskDetailView(task: task, isPresented: $hasPopup))
                    }else{
                        EmptyView()
                    }
                    
            }
        }
    }
}

#Preview {
    TaskListView()
}
