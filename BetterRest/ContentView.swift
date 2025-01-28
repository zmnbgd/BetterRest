//
//  ContentView.swift
//  BetterRest
//
//  Created by Marko Zivanovic on 16.1.25..
//

import CoreML
import SwiftUI

struct ContentView: View {
    
   // @State private var wakeUp = Date.now
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                //MARK: - Challenge - BetterRest - 1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
//                VStack(alignment: .leading, spacing: 0) {
                Section("Enter the time you want to wake up at.") {
                    Text("Where do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                }
                
//                VStack(alignment: .leading, spacing: 0) {
                Section("Enter how long you want to sleep.") {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 0...24, step: 0.10)
                        
                }
                
//                VStack(alignment: .leading, spacing: 0) {
//                Section("Enter how much coffee you drink during the day") {
//                    Text("Daily coffee intake")
//                        .font(.headline)
//                    //Stepper("\(coffeeAmount) cup's", value: $coffeeAmount, in: 0...20, step: 1)
//                    //Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",  value: $coffeeAmount, in: 1...20)
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
//                }
                //MARK: - Challenge - BetterRest - 2. Replace the “Number of cups” stepper with a Picker showing the same range of values.
                Section("Enter how much you drink coffee during the day") {
                    Picker("Coffee amount", selection: $coffeeAmount) {
                        ForEach(0..<10) {
                            Text("Cup \($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Ok") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            
            //MARK: SleepCalculator read all data I need for sleep calculation
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            //MARK: 8:31
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is ... "
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showAlert = true
    }
    
}

#Preview {
    ContentView()
}
