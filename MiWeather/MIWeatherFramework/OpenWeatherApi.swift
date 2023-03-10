//
//  OpenWeatherApi.swift
//  MIWeatherFramework
//
//  Created by oussef on 07/03/2023.
//

import Foundation

struct OpenWeatherApi {
    static let baseURL = Constants.baseUrl
    static let key = Constants.apiKey
    static let EXCLUDE_PART = "minutely"
    static let UNITS = "metric"
    static func getUrl(latitude: Double, longitude: Double) -> String {
        return "\(baseURL)/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(key)&exclude=\(EXCLUDE_PART)&units=\(UNITS)"
    }
}
