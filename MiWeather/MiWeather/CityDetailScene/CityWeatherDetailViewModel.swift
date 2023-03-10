//
//  CityWeatherDetailViewModel.swift
//  MiWeather
//
//  Created by oussef on 09/03/2023.
//

import MIWeatherFramework
import Foundation

class CityWeatherDetailViewModel: NSObject {
    var weatherData:Response?
    var onCurrentWeather:() -> () = { }
    
    func getWeather(latitude:Double, longitude:Double){
        WeatherManager.shared.getWeatherDetails(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let response):
                self.weatherData = response
                self.onCurrentWeather()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
