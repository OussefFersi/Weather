//
//  WeatherManager.swift
//  MIWeatherFramework
//
//  Created by oussef on 09/03/2023.
//

import Foundation

public class WeatherManager {
    public static var shared = WeatherManager()
    private let networkManager = NetworkManager()
    
    private init(){
        
    }
    
    public func getWeatherDetails(latitude: Double, longitude: Double, completion:@escaping(Result<Response, NetworkError>) -> Void){
        let urlString = OpenWeatherApi.getUrl(latitude: latitude, longitude: longitude)
        if let url = URL(string: urlString){
            networkManager.fetchRequest(type: Response.self, url: url, completion: completion)
        }
    }
}
