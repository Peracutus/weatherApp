//
//  ForecastModel.swift
//  
//
//  Created by Роман on 19.03.2023.
//

import Foundation

// MARK: - ForecastModel
public struct ForecastModel: Codable {
    public let timelines: Timelines
    public let location: Location
}

// MARK: - Location
public struct Location: Codable {
    let lat, lon: Double
    public let name, type: String
}

// MARK: - Timelines
public struct Timelines: Codable {
    public let daily: [Daily]
}

// MARK: - Daily
public struct Daily: Codable, Identifiable, Equatable {
    public let time: String
    public let values: Values
    public var id: String { time }
}

// MARK: - Values
public struct Values: Codable, Equatable {
    public let moonriseTime, moonsetTime: String?
    public let sunriseTime, sunsetTime: String
    public let temperatureMax,temperatureAvg, temperatureMin: Double
    public let windSpeedAvg: Double
}
