//
//  CalendarViewModel.swift
//  Habit
//
//  Created by Logan Cowley on 11/20/25.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var startHour: Int = 5
    @Published var endHour: Int = 23
    @Published var hourHeight : CGFloat = 90
    @Published var events: [Task] = Task.mockTasks // Change to empty later
    @Published var use24HourFormat: Bool = false
    
    let eventProcessor = EventProcessor()
}
