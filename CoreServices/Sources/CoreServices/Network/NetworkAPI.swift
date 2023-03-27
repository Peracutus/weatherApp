//
//  NetworkAPI.swift
//  
//
//  Created by Роман on 19.03.2023.
//

import Foundation

public protocol NewtworkAPIProtocol: AnyObject {
    func fetchForecastData(location: String, responce: @escaping(ForecastModel?, Error?) -> Void)
    func fetchNews(nextPage: String, responce: @escaping(NewsModel?, Error?) -> Void)
}

public final class NetworkAPI: NewtworkAPIProtocol {
    
    public static let shared = NetworkAPI()
    public init() {}
    
    public func fetchForecastData(location: String, responce: @escaping(ForecastModel?, Error?) -> Void) {
        
        let apiKey = "kz9zqczftY0hDQUx7uP2jXSvzPnfDDU1"
        let url = "https://api.tomorrow.io/v4/weather/forecast?location=\(location)&apikey=\(apiKey)"
        
        NetworkRequest.shared.requestData(urlString: url) { result in
            switch result {
            case.success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .deferredToDate
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let forecast = try decoder.decode(ForecastModel.self, from: data)
                    responce(forecast, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case.failure(let error):
                print("Error received reusting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
    
    public func fetchNews(nextPage: String, responce: @escaping(NewsModel?, Error?) -> Void) {
        let apiKey = "pub_19354a319cd8fa2c1df62b159d730dc60956e"
        let url = "https://newsdata.io/api/1/news?apikey=\(apiKey)&language=ru&page=\(nextPage)"
        NetworkRequest.shared.requestData(urlString: url) { result in
            switch result {
            case.success(let data): /// может возникнуть проблема с декодированием Json
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .deferredToDate
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let news = try decoder.decode(NewsModel.self, from: data)
                    responce(news, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case.failure(let error):
                print("Error received reusting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
