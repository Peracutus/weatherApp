//
//  Reducer.swift
//  weatherForecast
//
//  Created by Роман on 30.03.2023.
//

import Foundation
import CoreServices
import ComposableArchitecture

struct Feature: ReducerProtocol {
    
    let network = NetworkAPI() /// заменить на протокол

    struct State: Equatable {
        var isLoading = false
        var weatherData: [Daily] = []
    }
    
    enum Action: Equatable {
        case getWeatherData
        case getRequestResult(TaskResult<[Daily]>)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .getWeatherData:
            state.isLoading = true
            return .task { 
                await .getRequestResult(TaskResult {
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
                })
            }
        case let .getRequestResult(.success(loadedData)):
            state.isLoading = false
            state.weatherData = loadedData
            print(loadedData)
            return .none
        case let .getRequestResult(.failure(error)):
            state.isLoading = false
            print("error : \(error)")
            return .none
        }
    }
}


