//
//  PopupView.swift
//  Habit
//
//  Created by Logan Cowley on 11/12/25.
//

import SwiftUI

struct PopupView<Content: View>: View {
    let content: Content
    
    var body: some View {
        VStack{
            HStack {
                Text("Add task")// Change later
                    .font(.headline)
                    .padding(.horizontal, 115)
                    .padding(.vertical)
                    .background(Color(.blue))
                    .foregroundColor(.white)
            }
            content
                .background(.gray)
                .frame(width: 300)
        }
    }
}

#Preview {
    @Previewable @State var hasPopup: Popup = .addTask
    let viewModel = AppViewModel()
    let addView = TaskAddView(isPresented: $hasPopup)
        .environmentObject(viewModel)
    PopupView(content: addView)
}
