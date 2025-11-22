//
//  TaskView.swift
//  Habit
//
//  Created by Logan Cowley on 10/25/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var hasPopup: Popup = .noPopup
    
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
                            TaskCardView(taskId: task.id)
                                .onTapGesture {
                                    viewModel.selectedID = task.id
                                    hasPopup = .detailTask
                                }
                        }
                    }
                }.navigationTitle(Text("Tasks"))
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
                    PopupView(content: TaskAddView(isPresented: $hasPopup))
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
    let viewModel = AppViewModel()
    
    TaskListView()
        .environmentObject(viewModel)
}
