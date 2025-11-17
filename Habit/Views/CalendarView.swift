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
  let calendarHeight: CGFloat
  let events: [Task]
  var use24HourFormat: Bool
  let eventProcessor = EventProcessor()

  private let hourLabel: CGSize = .init(width: 38, height: 38)
  private let offsetPadding: Double = 10

  /// The height of each hour in the calendar.
  private var hourHeight: CGFloat {
    calendarHeight / CGFloat(endHour - startHour + 1)
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
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(overlappingEvents) { event in
                            eventCell(for: event)
                        }
                    }
                }
                .offset(x: hourLabel.width + offsetPadding)
                .padding(.trailing, hourLabel.width + offsetPadding)
            }
        }
        .frame(minHeight: calendarHeight, alignment: .bottom)
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
    let offsetPadding: CGFloat = 18

    var duration: Double {
        return event.endTime.timeIntervalSince(event.startTime)
    }

    var height: Double {
      let timeHeight = (duration / 60 / 60) * Double(hourHeight)
      return timeHeight < 16 ? 16 : timeHeight
    }

    let calendar = Calendar.current

    var hour: Int {
        return calendar.component(.hour, from: event.startTime)
    }

    var minute: Int {
        return calendar.component(.minute, from: event.startTime)
    }

    var offset: Double {
      (Double(hour - startHour) * Double(hourHeight)) +
        (Double(minute) / 60 * Double(hourHeight)) +
        offsetPadding
    }

    return Text(event.title)
      .bold()
      .padding()
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: CGFloat(height))
      .minimumScaleFactor(0.6)
      .multilineTextAlignment(.leading)
      .background(
        Rectangle()
          .fill(Color.mint.opacity(0.6))
          .padding(1)
      )
      .offset(y: CGFloat(offset))
  }
}
#Preview {
    CalendarView2(
          startHour: 5,
          endHour: 23,
          calendarHeight: 1200,
          events: Task.mockTasks,
          use24HourFormat: false
        )
}
