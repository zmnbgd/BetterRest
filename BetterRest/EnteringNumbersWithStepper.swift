//
//  EnteringNumbersWithStepper.swift
//  BetterRest
//
//  Created by Marko Zivanovic on 16.1.25..
//

import SwiftUI

struct EnteringNumbersWithStepper: View {
    
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours,", value: $sleepAmount, in: 0...24, step: 0.10)
    }
}


#Preview {
    EnteringNumbersWithStepper()
}
