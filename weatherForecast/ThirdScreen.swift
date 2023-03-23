//
//  ThirdScreen.swift
//  weatherForecast
//
//  Created by Роман on 18.03.2023.
//

import SwiftUI

struct ThirdScreen: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Button("Show Modal View") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                ModalView()
            }
        }
    }
}

struct ModalView: View {
    
    @State private var titleLable = "Этот лейбл из UIKit"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            DocumentNameLabel(content: $titleLable)
                .frame(height: 40)
                .padding(50)
                .cornerRadius(10)
            Button("Press to dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
            .cornerRadius(10)
        }
    }
}

struct DocumentNameLabel: UIViewRepresentable {
    
    @Binding var content: String
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.1548551422, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        label.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = content
    }
}

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen()
    }
}
