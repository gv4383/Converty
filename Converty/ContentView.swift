//
//  ContentView.swift
//  Converty
//
//  Created by Goyo Vargas on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var originalMeasurement = ""
    @State private var originalMeasurementUnit = 1
    @State private var convertedMeasurementUnit = 2
    
    let temperatureUnits = ["K", "C", "F"]
    
    var convertedMeasurement: Double {
        let originalMeasurementDouble = Double(originalMeasurement) ?? 0
        
        if temperatureUnits[convertedMeasurementUnit] == temperatureUnits[originalMeasurementUnit] {
            return originalMeasurementDouble
        }
        
        var convertedMeasurementToKelvin = originalMeasurementDouble
        
        if temperatureUnits[originalMeasurementUnit] == "C" {
            let convertedCelsiusToKelvin = originalMeasurementDouble + 273.15
            convertedMeasurementToKelvin = convertedCelsiusToKelvin
        }
        
        if temperatureUnits[originalMeasurementUnit] == "F" {
            let convertedFahrenheitToKelvin = (originalMeasurementDouble - 32) * 5 / 9 + 273.15
            
            convertedMeasurementToKelvin = convertedFahrenheitToKelvin
        }
        
        var finalConvertedMeasurement = convertedMeasurementToKelvin
        
        if temperatureUnits[convertedMeasurementUnit] == "C" {
            let convertedKelvinToCelsius = convertedMeasurementToKelvin - 273.15
            finalConvertedMeasurement = convertedKelvinToCelsius
        }
        
        if temperatureUnits[convertedMeasurementUnit] == "F" {
            let convertedKelvinToFahrenheit = (convertedMeasurementToKelvin - 273.15) * 9 / 5 + 32
            finalConvertedMeasurement = convertedKelvinToFahrenheit
        }
        
        return finalConvertedMeasurement
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Original measurement and unit")) {
                    TextField("Temperature", text: $originalMeasurement)
                        .keyboardType(.decimalPad)
                    Picker("Original measurement unit", selection: $originalMeasurementUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Unit to convert to")) {
                    Picker("Converted measurement unit", selection: $convertedMeasurementUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Converted measurement")) {
                    Text("\(convertedMeasurement, specifier: "%.1f") \(temperatureUnits[convertedMeasurementUnit])")
                }
            }
            .navigationBarTitle("Converty")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
