//
//  TaskDetailView.swift
//  Habit
//
//  Created by Logan Cowley on 10/25/25.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var isPresented: Popup
    var task: Task
    @State private var title: String
    @State private var description: String
    
    init(task: Task, viewModel: TaskViewModel, isPresented: Binding<Popup>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
        self.task = task
        _title = State(initialValue: task.title)
        _description = State(initialValue: task.description)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Title")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(task.theme.accentColor)
            TextField("Enter Title", text: $title)
                .padding()
                .border(task.theme.accentColor, width:2)
                .background(.white)
                .foregroundColor(.black)
            Text("Description")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(task.theme.accentColor)
            TextField("Enter Description", text: $description, axis: .vertical)
                .padding()
                .border(task.theme.accentColor, width:2)
                .lineLimit(5, reservesSpace: true)
                .background(.white)
                .foregroundColor(.black)
            HStack{
                Spacer()
                Button(){
                    viewModel.changeTaskTitle(for: task, to: title)
                    viewModel.changeTaskDescription(for: task, to: description)
                    isPresented = .noPopup
                }label: {
                    Text("Save")
                }.foregroundColor(Color(.white))
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                 .background(Capsule().fill(.green))
                 .shadow(radius: 2)
            }
        }.padding()
            .background(Color(.slate))
    }
}

#Preview {
    @Previewable @StateObject var viewModel = TaskViewModel()
    @Previewable @State var isPresented: Popup = .detailTask
    let task = viewModel.tasks[1]
    TaskDetailView(task: task, viewModel: viewModel, isPresented: $isPresented)
}
