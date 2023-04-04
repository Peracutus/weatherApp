//
//  WeatherFluxScreen.swift
//  weatherForecast
//
//  Created by Роман on 30.03.2023.
//

import SwiftUI
import ComposableArchitecture

struct WeatherFluxScreen: View {
    
    let stateStore: StoreOf<Feature>
    
    var body: some View {
        WithViewStore(stateStore) { viewStore in
            GeometryReader { geom in
                List {
                    ForEach(viewStore.weatherData) { data in
                        Text("Hellow")
                        Text(data.time)
                    }
                    Button("tap") {
                        viewStore.send(.getWeatherData)
                    }
                }
            }
            .onAppear {
                viewStore.send(.getWeatherData)
            }
        }
    }
}
