//
//  ContentView.swift
//  LengthConv
//
//  Created by Karthigeyan Vijayakumar on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var selectedInputUnit = 0
    @State private var selectedOutputUnit = 0
    
    enum LengthUnits: String {
        case METERS = "m"
        case KILOMETERS = "km"
        case FEET = "ft"
        case YARDS = "yd"
        case MILES = "mi"
    }
    
    let supportedUnits = [LengthUnits.METERS, LengthUnits.KILOMETERS, LengthUnits.FEET, LengthUnits.YARDS, LengthUnits.MILES]
    
    var convertedValue: Double {
        let fromValue = Double(inputValue) ?? 0
        var midValue = 0.0
        var finalValue = 0.0
        
        switch(supportedUnits[selectedInputUnit]) {
        case .METERS:
            midValue = fromValue
        case .KILOMETERS:
            midValue = fromValue * 1000
        case .FEET:
            midValue = fromValue / 3.281
        case .YARDS:
            midValue = fromValue / 1.094
        case .MILES:
            midValue = fromValue * 1609
        }
        
        switch(supportedUnits[selectedOutputUnit]) {
        case .METERS:
            finalValue = midValue
        case .KILOMETERS:
            finalValue = midValue / 1000
        case .FEET:
            finalValue = midValue * 3.281
        case .YARDS:
            finalValue = midValue * 1.094
        case .MILES:
            finalValue = midValue / 1609
        }
        
        return finalValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input", text: $inputValue).keyboardType(.decimalPad)
                }
                Section(header: Text("From")) {
                    Picker("From Units", selection: $selectedInputUnit) {
                        ForEach(0..<supportedUnits.count) {
                            Text("\(self.supportedUnits[$0].rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("To")) {
                    Picker("To Units", selection: $selectedOutputUnit) {
                        ForEach(0..<supportedUnits.count) {
                            Text("\(self.supportedUnits[$0].rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(convertedValue, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("LengthConv")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
