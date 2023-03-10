//
//  WeatherResponse.swift
//  MIWeatherFramework
//
//  Created by oussef on 07/03/2023.
//

import Foundation

public struct Response: Codable {
    
    let lat: Double
    let lon: Double
    public let timezone: String
    public let timezone_offset: Double
    public let current: Current
    public var hourly: [Hourly]
    public var daily: [Daily]
    
   
}

public struct Current: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    public let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    public let clouds: Int
    let visibility:Int
    let wind_speed: Double
    let wind_deg: Int
    public let weather: [Weather]
}

public struct Hourly: Codable {
    public let dt: Int
    public let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let visibility:Int
    let clouds: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    public let weather: [Weather]
    let pop:Double
}

public struct Daily: Codable {
    public let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise:Int
    let moonset:Int
    let moon_phase:Double
    let temp: Temperature
    let feels_like: FeelsLike
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    public let weather: [Weather]
    let clouds: Int
    let pop:Double
    let uvi: Double
}

public struct Temperature: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

public struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
