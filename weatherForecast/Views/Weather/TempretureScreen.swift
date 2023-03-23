//
//  TempretureScreen.swift
//  weatherForecast
//
//  Created by Роман on 21.03.2023.
//

import SwiftUI
import CoreServices

struct TempretureScreen: View {
    
    let temperatureMax, temperatureAvg, temperatureMin: Double
    
    @EnvironmentObject private var navigation: NavigationStackViewModel
    
    var body: some View {
        VStack {
            Text("Max temp is \(temperatureMax)")
            Text("Avg temp is \(temperatureAvg)")
            Text("Min temp is \(temperatureMin)")
            Button {
                navigation.pop()
            } label: {
                Text("Back")
            }
        }
    }
}

struct TempretureScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
