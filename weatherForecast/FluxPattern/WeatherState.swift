//
//  WeatherState.swift
//  weatherForecast
//
//  Created by Роман on 30.03.2023.
//

import Foundation
import CoreServices

struct WeatherState: Equatable {
    var isLoading = false
    var weatherData: [Daily] = []
}
