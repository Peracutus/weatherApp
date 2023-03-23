//
//  NavigationViewController.swift
//  weatherForecast
//
//  Created by Роман on 21.03.2023.
//

import Foundation
import SwiftUI

struct NavigationViewController<Content>: View where Content: View {
    private let content: Content
    private let transition: (push: AnyTransition, pop: AnyTransition)
    @ObservedObject private var viewModel: NavigationStackViewModel
    
    init(viewModel: NavigationStackViewModel = NavigationStackViewModel(easing: .easeOut(duration: 0.9)),
         transition: AnimationType,
         @ViewBuilder contentBuilder: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        content = contentBuilder()
        switch transition {
        case .none:
            self.transition = (push: .identity, pop: .identity)
        case .custom(let push, let pop):
            self.transition = (push: push, pop: pop)
        }
    }
    
    var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                content
                /// можно добавить жесты и другие действия
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            } else {
                viewModel.currentScreen?.screenView
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            }
        }
    }
}
