//
//  Weather.swift
//  MIWeatherFramework
//
//  Created by oussef on 07/03/2023.
//

import Foundation

public struct Weather: Codable {
    let id: Int
    public let main: String
    public let description: String
    public let icon: String
}
