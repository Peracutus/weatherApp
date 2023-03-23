//
//  NewsModel.swift
//  
//
//  Created by Роман on 23.03.2023.
//

import Foundation

// MARK: - NewsModel
public struct NewsModel: Codable {
    public let results: [NewsArray]?
    public let nextPage: String?
}

// MARK: - Result
public struct NewsArray: Codable, Identifiable {
    public var id: String { title ?? "" }
    public let title: String?
    public let link: String?
    public let keywords: [String]?
    public let description, content: String?
    public let imageURL: String?
}
