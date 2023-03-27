//
//  WeatherForecastApp.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI
import CoreServices

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

final class Configurator {
    static let shared = Configurator()
    
    private init() {}
    
    func setNetworkAPIService() {
        let networkService: NewtworkAPIProtocol = NetworkAPI()
        ServiceLocator.shared.addService(service: networkService)
    }
}
