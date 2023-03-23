//
//  Types.swift
//  weatherForecast
//
//  Created by Роман on 21.03.2023.
//

import SwiftUI

enum NavigationType {
     case push, pop
}

enum AnimationType {
    case none
    case custom(push: AnyTransition, pop: AnyTransition)
}

enum PopDestination {
    case previous, root
}

struct Screen: Identifiable {
    let id: String
    let screenView: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}
