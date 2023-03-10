//
//  WeatherManager.swift
//  MIWeatherFramework
//
//  Created by oussef on 09/03/2023.
//

import Foundation

/// WeatherManager
public class WeatherManager {
    //shared instance of WeatherManager
    public static var shared = WeatherManager()
    private let networkManager = NetworkManager()
    
    private init(){
        
    }
    
    /// This method call  all weather information from given location
    /// - Parameters:
    ///   - latitude: latitude location cordinate
    ///   - longitude: longitude  location cordinate
    ///   - completion: response call back
    public func getWeatherDetails(latitude: Double, longitude: Double, completion:@escaping(Result<Response, NetworkError>) -> Void){
        let urlString = OpenWeatherApi.getUrl(latitude: latitude, longitude: longitude)
        if let url = URL(string: urlString){
            networkManager.fetchRequest(type: Response.self, url: url, completion: completion)
        }
    }
}
