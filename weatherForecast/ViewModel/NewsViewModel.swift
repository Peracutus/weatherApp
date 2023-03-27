//
//  NewsViewModel.swift
//  weatherForecast
//
//  Created by Роман on 23.03.2023.
//

import SwiftUI
import CoreServices

final class NewsViewModel: ObservableObject {
    
    @Published var newsDetails: [NewsArray] = []
    @Published var nextPage: String = ""
    @Injected private var networkService: NewtworkAPIProtocol?
    
    var isLoading = false
    
    init() {
        loadNews(nextPage: "")
    }
    
    func loadNews(nextPage: String) {
        isLoading = true
        networkService?.fetchNews(nextPage: nextPage) { [weak self] news, error   in
            if error == nil {
                self?.isLoading = false
                self?.nextPage = news?.nextPage ?? ""
                self?.newsDetails = news?.results ?? []
                
            } else {
                self?.isLoading = false
                debugPrint(error ?? "")
            }
        }
    }
}
