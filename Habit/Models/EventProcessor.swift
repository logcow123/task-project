//
//  EventProcessor.swift
//  Habit
//
//  Created by Logan Cowley on 11/17/25.
//

import Foundation

struct EventProcessor{
    
    func processEvents(_ events: [Task]) -> [[Task]]{
        
        let sortedEvents = events.sorted { $0.startTime < $1.startTime }
        
        var processedEvents: [[Task]] = []
        var currentEvents: [Task] = []
        
        for event in sortedEvents{
            if let latestEndTime = currentEvents.map({$0.endTime}).max(),
               event.startTime < latestEndTime{
                currentEvents.append(event)
            } else{
                if !currentEvents.isEmpty{
                    processedEvents.append(currentEvents)
                }
                currentEvents = [event]
            }
            if !currentEvents.isEmpty{
                processedEvents.append(currentEvents)
            }
        }
        
        return processedEvents
    }
}
