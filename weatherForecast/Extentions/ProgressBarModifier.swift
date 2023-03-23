//
//  ProgressBarModifier.swift
//  weatherForecast
//
//  Created by Роман on 23.03.2023.
//
import Foundation
import SwiftUI

struct ProgressBarModifier: ViewModifier {
    let withLoading: Bool

    func body(content: Content) -> some View {
        let _ = print("Working : \(withLoading)")
        if withLoading {
            VStack {
                content
                Divider()
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
            }
        } else {
            content
        }
    }
}
