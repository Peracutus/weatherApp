//
//  DetailView.swift
//  weatherForecast
//
//  Created by Роман on 21.03.2023.
//

import SwiftUI

struct DetailView: View {

    let cityName, moonriseTime, moonsetTime, sunsetTime, windSpeedAvg: String
    let temperatureMax, temperatureAvg, temperatureMin: Double
    
    @EnvironmentObject var nav: NavigationStackViewModel
    
    var body: some View {
        VStack {
            Text("Details about : \(cityName)")
            Text("moonriseTime about : \(moonriseTime)")
            Text("moonsetTime about : \(moonsetTime)")
            Text("sunsetTime about : \(sunsetTime)")
            Text("windSpeedAvg about : \(windSpeedAvg)")
            Button {
                nav.push(newView: TempretureScreen(temperatureMax: temperatureMax,
                                                   temperatureAvg: temperatureAvg,
                                                   temperatureMin: temperatureMin))
            } label: {
                Text("Подробно о температуре")
            }
            Button {
                nav.pop()
            } label: {
                Text("Back")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
