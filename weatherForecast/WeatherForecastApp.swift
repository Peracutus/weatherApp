//
//  WeatherForecastApp.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PersonsViewModel())
                .environmentObject(WeatherViewModel())
        }
    }
}
