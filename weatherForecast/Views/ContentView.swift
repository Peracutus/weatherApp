//
//  ContentView.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedView = 1
    @State private var isShowingDetailView = false
    
    init() {
        Configurator.shared.setNetworkAPIService()
    }
    
    var body: some View {
        NavigationViewController(transition: .custom(push: .slide, pop: .opacity)) {
            TabView(selection: $selectedView) {
                WeatherScreen()
                    .tabItem {
                        Label("Forecast", systemImage: "cloud.sun")
                    }.tag(1)
                SecondScreen(isShowingDetailView: $isShowingDetailView)
                    .navigationTitle("Second Tab name")
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Second")
                    }.tag(2)
                ThirdScreen()
                    .navigationTitle("Modal view")
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Third")
                    }.tag(3)
                NewsScreen()
                    .navigationTitle("News View")
                    .tabItem {
                        Label("News", systemImage: "newspaper.fill")
                    }.tag(4)
            }
        }
    }
}

struct CircleNumberView: View {
    
    @Binding var tabSelection: Int
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.red)
                    Text("1")
                        .foregroundColor(.white)
                        .font(.system(size: 70, weight: .bold))
                }
                Button {
                    tabSelection = 2
                    isShowingDetailView = true
                } label: {
                    Text("Go to second \nwith chosen cell")
                }
                .cornerRadius(10)
                .frame(width: 200)
            }.navigationTitle("Red circle")
        }.phoneOnlyStackNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
