//
//  TaskCalendarView.swift
//  Habit
//
//  Created by Logan Cowley on 11/17/25.
//

import SwiftUI

struct TaskCalendarView: View {
    var task: Task
    var showTime: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundStyle(Color.blue)
                .frame(maxWidth: 10, maxHeight: .infinity)
            HStack {
                VStack {
                    HStack {
                        Text(task.title)
                            .font(.callout)
                        Spacer()
                        Menu(){
                            Button(){}label: {
                                Image(systemName: "circle")
                                    .foregroundColor(.black)
                            }
                        }label: {
                            Image(systemName: "circle")
                                .foregroundColor(.black)
                        }.padding(.horizontal)
                    }
                    .padding(.top, 10)
                    .padding(.leading)
                    Spacer()
                    if showTime{
                        HStack {
                            Text("\(task.startTime.formatted(date: .omitted, time: .shortened)) - \(task.endTime.formatted(date: .omitted, time: .shortened))")
                                .font(.caption)
                            Spacer()
                        }
                        .padding(.bottom)
                        .padding(.leading)
                    }
                }
                Spacer()
            }.background(Color.blue.opacity(0.3))
        }.frame(minHeight: 40)
    }
}

#Preview {
    let task: Task = .mockTasks[1]
    TaskCalendarView(task: task, showTime: true)
        .frame(height: 70)
}
