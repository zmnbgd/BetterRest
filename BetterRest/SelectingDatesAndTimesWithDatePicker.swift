//
//  SelectingDatesAndTimesWithDatePicker.swift
//  BetterRest
//
//  Created by Marko Zivanovic on 16.1.25..
//

import SwiftUI

struct SelectingDatesAndTimesWithDatePicker: View {
    
    @State private var wakeUp = Date.now
    
    
    var body: some View {
        DatePicker("Please ente a date", selection: $wakeUp, in: Date.now...)
            .labelsHidden()
    }
    func exampleDates() {
        let tommorow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tommorow
        
    }
}

#Preview {
    SelectingDatesAndTimesWithDatePicker()
}
