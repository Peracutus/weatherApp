//
//  WeatherActions.swift
//  weatherForecast
//
//  Created by Роман on 30.03.2023.
//

import Foundation
import ComposableArchitecture
import CoreServices

enum WeatherActions {
    case getWeatherData
    case getRequestResult(TaskResult<[Daily]>)
}

