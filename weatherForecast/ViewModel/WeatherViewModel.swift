//
//  WeatherViewModel.swift
//  weatherForecast
//
//  Created by Роман on 22.03.2023.
//

import SwiftUI
import CoreServices

final class WeatherViewModel: ObservableObject {
    
    @Published var details: [Daily] = .init()
    var detailsForIOS13Grid: [[Daily]] = .init()
    @Published var forecastWeather: [ForecastModel] = .init()
    @Published var listTypeChoice = 0
    @Injected private var networkService: NewtworkAPIProtocol?
    
    init() {
        loadWeather()
    }
    
    func loadWeather() {
        let location: String
        switch listTypeChoice {
        case 0: location = "moscow"
        case 1: location = "newyork"
        case 2: location = "spb"
        default:
            location = "moscow"
        }
        
        networkService?.fetchForecastData(location: location) { [weak self] forecast, error  in
            if error == nil {
                guard let details = forecast?.timelines.daily,
                      let forecast = forecast else { return }
                self?.forecastWeather = [forecast]
                self?.details = details
                self?.collectAsArray2D()
            } else {
                debugPrint(error ?? "")
            }
        }
    }
    
    func collectAsArray2D() {
        let columned = details.publisher.collect(2) // [[0,1], [2, 3], ...]
        _ = columned.collect().sink {
            self.detailsForIOS13Grid = $0
        }
    }
}
