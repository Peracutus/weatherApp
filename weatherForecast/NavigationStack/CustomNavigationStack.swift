//
//  CustomNavigationStack.swift
//  weatherForecast
//
//  Created by Роман on 21.03.2023.
//

import Foundation
import SwiftUI

struct CustomNavigationStack {
    var screens: [Screen] = []
    var top: Screen? { screens.last } /// получаем верхний
    
    mutating func push(newScreen: Screen) {
        screens.append(newScreen) /// пуш
    }
    
    mutating func pop() {
        _ = screens.popLast() /// извлечь из стека верхний элемент и увидеть следующий
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}

final class NavigationStackViewModel: ObservableObject {
    
    private let easing: Animation
    var navigationType = NavigationType.push
    @Published var currentScreen: Screen? /// верхний экран
   
    var screensStack = CustomNavigationStack() {
        didSet {
            currentScreen = screensStack.top
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push<S: View>(newView: S) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, screenView: AnyView(newView))
            screensStack.push(newScreen: screen)
        }
    }
    
    func pop(destination: PopDestination = .previous) {
        withAnimation(easing) {
            navigationType = .pop
            switch destination {
            case .previous:
                screensStack.pop()
            case .root:
                screensStack.popToRoot()
            }
        }
    }
}
