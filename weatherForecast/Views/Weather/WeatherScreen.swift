//
//  WeatherScreen.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI
import CoreServices
import Foundation


struct WeatherScreen: View {
    
    @State private var isChanged = false
    
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject private var navigation: NavigationStackViewModel
    
    var listTypes = ["Moscow", "NewYork", "Saint-Petersburg"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker("options", selection: $weatherViewModel.listTypeChoice) {
                        ForEach(0 ..< listTypes.count, id: \.self) { index in
                            Text(self.listTypes[index]).tag(index)
                        }.onChange(of: weatherViewModel.listTypeChoice) { value in
                            weatherViewModel.loadWeather()
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                    
                    switch weatherViewModel.listTypeChoice {
                    case 0: /// применение VGrid
                        LazyVGrid(columns: Array<GridItem>(repeating: .init(), count: 2)) {
                            ForEach(weatherViewModel.details, id: \.id) { index in
                                let dateFormatter = ISO8601DateFormatter()
                                let date = dateFormatter.date(from: index.time)
                                WeatherCell(cityTitle: "Москва",
                                            tempreture: "\(index.values.temperatureAvg) °C",
                                            date: date!).offset(CGSize(width: isChanged ? 300.0 : 0.0, height: 0.0))
                                .animation(.easeInOut(duration: 0.3), value: isChanged)
                                .onTapGesture {
                                    self.isChanged.toggle()
                                    navigation.push(newView: DetailView(
                                        cityName: weatherViewModel.forecastWeather[0].location.name,
                                        moonriseTime: index.values.moonriseTime ?? "nil",
                                        moonsetTime: index.values.moonsetTime ?? "nil",
                                        sunsetTime: index.values.sunsetTime,
                                        windSpeedAvg: String(index.values.windSpeedAvg),
                                        temperatureMax: index.values.temperatureMax,
                                        temperatureAvg: index.values.temperatureAvg,
                                        temperatureMin: index.values.temperatureMin))
                                }
                            }
                        }
                    case 1: /// Grid for IOS 13
                        VStack(spacing: 8) {
                            ForEach(0..<weatherViewModel.detailsForIOS13Grid.count, id: \.self) { row in
                                HStack(spacing: 8) {
                                    ForEach(weatherViewModel.detailsForIOS13Grid[row]) { article in
                                        let dateFormatter = ISO8601DateFormatter()
                                        let date = dateFormatter.date(from: article.time)
                                        WeatherCell(cityTitle: "Нью-Йорк",
                                                    tempreture: "\(article.values.temperatureAvg) °C",
                                                    date: date!)
//                                        .offset(CGSize(width: isChanged ? 300.0 : 0.0, height: 0.0))
                                        .animation(.easeOut(duration: 0.2), value: isChanged)
                                        .onTapGesture {
                                            self.isChanged.toggle()
                                            navigation.push(newView: DetailView(
                                                cityName: "Нью-Йорк",
                                                moonriseTime: article.values.moonriseTime ?? "nil",
                                                moonsetTime: article.values.moonsetTime ?? "nil",
                                                sunsetTime: article.values.sunsetTime,
                                                windSpeedAvg: String(article.values.windSpeedAvg),
                                                temperatureMax: article.values.temperatureMax,
                                                temperatureAvg: article.values.temperatureAvg,
                                                temperatureMin: article.values.temperatureMin))
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    case 2:
                        ForEach(weatherViewModel.details, id: \.id) { index in
                            let dateFormatter = ISO8601DateFormatter()
                            let date = dateFormatter.date(from: index.time)
                            WeatherCell(cityTitle: "Санкт-Петербург",
                                        tempreture: "\(index.values.temperatureAvg) °C",
                                        date: date!)
                            .onTapGesture {
                                withAnimation(.easeIn) { isChanged.toggle() }
                                navigation.push(newView: DetailView(
                                    cityName: weatherViewModel.forecastWeather[0].location.name,
                                    moonriseTime: index.values.moonriseTime ?? "nil",
                                    moonsetTime: index.values.moonsetTime ?? "nil",
                                    sunsetTime: index.values.sunsetTime,
                                    windSpeedAvg: String(index.values.windSpeedAvg),
                                    temperatureMax: index.values.temperatureMax,
                                    temperatureAvg: index.values.temperatureAvg,
                                    temperatureMin: index.values.temperatureMin))
                            }
                        }
                    default:
                        EmptyView()
                    }
                    Spacer()
                }
            }.navigationTitle("Weather forecast")
        }
    }
}

struct WeatherCell: View {
    
    var cityTitle: String
    var tempreture: String
    var date: Date
    
    var body: some View {
        HStack {
            VStack{
                Image(systemName: "cloud.sun")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                Text(tempreture)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }.padding(.horizontal, 10)
            VStack {
                Text(cityTitle)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .minimumScaleFactor(0.5)
                    .padding(.vertical, 5)
                Text("\(date)")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .frame(height: 100)
        }.padding(.horizontal)
    }
}

struct WeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen()
    }
}
