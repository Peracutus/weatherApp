//
//  ViewExtention.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else { self }
    }
}
