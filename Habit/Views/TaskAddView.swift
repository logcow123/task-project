//
//  TaskAddView.swift
//  Habit
//
//  Created by Logan Cowley on 11/11/25.
//

import SwiftUI

struct TaskAddView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var title: String = ""
    @State private var description: String = ""
    @Binding var isPresented: Popup
    
    var body: some View {
        VStack {
            Text("Title")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .font(.headline)
            TextField("Enter Title", text: $title)
                .padding()
                .background(.white)
                .border(.black, width: 2)
            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            TextField("Enter Description", text: $description, axis: .vertical)
                .padding()
                .background(.white)
                .border(.black, width: 2)
                .lineLimit(5, reservesSpace: true)
            Button(action: {
                let myTask = Task(title: title, description: description)
                viewModel.addTask(task: myTask)
                isPresented = .noPopup
            }, label: {
                Text("Create")
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }).padding()
        }
        .padding()
        .background(.slate)
    }
}
#Preview{
    @Previewable @State var hasPopup: Popup = .addTask
    let viewModel = AppViewModel()
    TaskAddView(isPresented: $hasPopup)
        .environmentObject(viewModel)
}
