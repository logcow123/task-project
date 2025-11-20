//
//  CalendarView2.swift
//  Habit
//
//  Created by Logan Cowley on 11/17/25.
//

import SwiftUI

struct CalendarView: View {
    var startHour: Int
    var endHour: Int
    let hourHeight : CGFloat = 90
    let events: [Task]
    var use24HourFormat: Bool
    let eventProcessor = EventProcessor()
    
    private let hourLabel: CGSize = .init(width: 38, height: 38)
    private let offsetPadding: Double = 10

    private var totalCalendarHeight: CGFloat {
        CGFloat(endHour - startHour + 1) * hourHeight
    }
    /// Groups the overlapping events together.
    private var overlappingEventGroups: [[Task]] {
        eventProcessor.processEvents(events)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ZStack(alignment: .topLeading) {
                    timeHorizontalLines
                    
                    ForEach(overlappingEventGroups, id: \.self) { overlappingEvents in
                        if overlappingEvents.count > 1{
                            HStack(alignment: .top, spacing: 0) {
                                ForEach(overlappingEvents) { event in
                                    eventCell(for: event)
                                }
                            }
                        }else{
                            eventCell(for: overlappingEvents.first!)
                        }
                    }
                    .offset(x: hourLabel.width + offsetPadding)
                    .padding(.trailing, hourLabel.width + offsetPadding)
                }
            }
            .frame(minHeight: totalCalendarHeight, alignment: .bottom)
        }
        
    }
    
    /// A view displaying the horizontal time lines in the calendar.
    private var timeHorizontalLines: some View {
        VStack(spacing: 0) {
            ForEach(startHour ... endHour, id: \.self) { hour in
                HStack(spacing: 10) {
                    /// Display the formatted hour label.
                    Text(formattedHour(hour))
                        .font(.caption2)
                        .monospacedDigit()
                        .frame(width: hourLabel.width, height: hourLabel.height, alignment: .trailing)
                    Rectangle()
                        .fill(.gray.opacity(0.6))
                        .frame(height: 1)
                }
                .foregroundColor(.gray)
                .frame(height: hourHeight, alignment: .top)
            }
        }
    }
    
    /// Formats the hour string based on the 24-hour format setting.
    ///
    /// - Parameter hour: The hour value to format.
    /// - Returns: The formatted hour string.
    private func formattedHour(_ hour: Int) -> String {
        if use24HourFormat {
            return String(format: "%02d:00", hour)
        } else {
            switch hour {
            case 0, 12:
                return "12 \(hour == 0 ? "am" : "pm")"
            case 13...23:
                return "\(hour - 12) pm"
            default:
                return "\(hour) am"
            }
        }
    }
    
    /// Creates a view representing an event cell in the calendar.
    ///
    /// - Parameter event: The event to display.
    /// - Returns: A view representing the event cell.
    private func eventCell(for event: Task) -> some View {
        
        // Choose the snap interval (5, 10, 15 mins)
        let snapInterval = 5
        let threshHold = 70.0
        
        let snappedStart = snap(date: event.startTime, interval: snapInterval)
        let snappedEnd   = snap(date: event.endTime,   interval: snapInterval)
        
        let duration = snappedEnd.timeIntervalSince(snappedStart)
        
        let height = max((duration / 3600) * Double(hourHeight), 16)
        
        let cal = Calendar.current
        let hour = cal.component(.hour, from: snappedStart)
        let minute = cal.component(.minute, from: snappedStart)
        
        let offset = (Double(hour - startHour) * Double(hourHeight)) +
        (Double(minute) / 60 * Double(hourHeight)) +
        18
        
        return TaskCalendarView(task: event, showTime: height > threshHold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: height)
            .offset(y: offset)
    }
}
extension CalendarView {
    func snap(date: Date, interval: Int) -> Date{
        let cal = Calendar.current
        let minute = cal.component(.minute, from: date)

        let snapped = Int((Double(minute) / Double(interval)).rounded()) * interval

        return cal.date(bySetting: .minute, value: snapped, of: date) ?? date
    }
}

#Preview {
    CalendarView(
          startHour: 5,
          endHour: 23,
          events: Task.mockTasks,
          use24HourFormat: false
        )
}
