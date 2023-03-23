//
//  NetworkRequest.swift
//  
//
//  Created by Роман on 19.03.2023.
//

import Foundation

final class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    func requestData(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        let headers = ["accept": "application/json"]
        guard let url = URL(string: urlString) else { return }
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                } else {
                    guard let data = data else { return }
                    completion(.success(data))
                }
            }
        }
        dataTask.resume()
    }
}
