//
//  WeatherForecastApp.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI
import CoreServices
import ComposableArchitecture

@main
struct WeatherForecastApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherFluxScreen(stateStore: Store(
                initialState: Feature.State(),
                reducer: Feature()))
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
