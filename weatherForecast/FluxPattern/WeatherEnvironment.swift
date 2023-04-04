//
//  WeatherEnvironment.swift
//  weatherForecast
//
//  Created by Роман on 30.03.2023.
//

import Foundation
import CoreServices

struct WeatherEnvironment { /// файл не используется!
    let network = NetworkAPI() /// заменить на протокол
    
    func getWeatherData() async throws -> [Daily] {
        var arrey: [Daily] = []
        network.fetchForecastData(location: "newyork", responce: { forecast, error  in
            if error == nil {
                guard let forecast = forecast else { return }
                arrey = forecast.timelines.daily
            } else {
                debugPrint(error ?? "")
            }
        })
        return arrey
    }
}

