//
//  NewsScreen.swift
//  weatherForecast
//
//  Created by Роман on 23.03.2023.
//

import SwiftUI

struct NewsScreen: View {
    
    @ObservedObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(newsViewModel.newsDetails) { details in
                    let isLast = newsViewModel.newsDetails.isLast(details)
                    let _ = print(isLast)
                    Text(details.content ?? "")
                    Text(details.description ?? "")
                }
                .onAppear{
                    newsViewModel.loadNews(nextPage: newsViewModel.nextPage)
                }
            }
            .navigationTitle("News")
            .onAppear {
                newsViewModel.loadNews(nextPage: "")
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}


private extension View {
    func progressBar(isLoading: Bool) -> some View {
        self
            .modifier(ProgressBarModifier(withLoading: isLoading))
    }
}
