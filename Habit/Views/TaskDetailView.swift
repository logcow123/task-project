//
//  TaskDetailView.swift
//  Habit
//
//  Created by Logan Cowley on 10/25/25.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var task: Task
    @Binding var isPresented: Popup

    @State private var title: String
    @State private var description: String

    init(task: Binding<Task>, isPresented: Binding<Popup>) {
        _task = task
        _isPresented = isPresented
        
        _title = State(initialValue: task.wrappedValue.title)
        _description = State(initialValue: task.wrappedValue.description)
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
                Button(){
                    isPresented = .noPopup
                }label: {
                    Text("Cancel")
                }.foregroundColor(Color(.white))
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.horizontal, 23)
                    .padding(.vertical, 10)
                 .background(Capsule().fill(.red))
                 .shadow(radius: 2)
                Spacer()
                Button(){
                    task.title = title
                    task.description = description
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
    @Previewable @State var isPresented: Popup = .detailTask
    @Previewable @State var task = Task.exampleTask
    TaskDetailView(task: $task, isPresented: $isPresented)
}
