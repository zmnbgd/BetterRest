//
//  WorkingWithDates.swift
//  BetterRest
//
//  Created by Marko Zivanovic on 17.1.25..
//

import SwiftUI

struct WorkingWithDates: View {
    var body: some View {
        Text(Date.now, format: .dateTime.day().month().year().hour().minute())
        Text(Date.now.formatted(date: .long, time: .shortened))
            Image(systemName: "calendar")
                .foregroundColor(.blue)
                .font(.largeTitle)

    }
    
    func exampleDates() {
        let now = Date.now
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = now...tomorrow
    }
    
    func exampleDates2() {
        var components = DateComponents()
        components.day = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now
    }
    
    func exampleDates3() {
        let components3 = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components3.hour ?? 0
        let minute = components3.minute ?? 0
    }
}

#Preview {
    WorkingWithDates()
}
