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
    var onError: (_ message:String) -> () = {_ in }
    var onCurrentWeather:() -> () = { }
    var onLoading:(Bool) -> () = {_ in }
    var isLoading:Bool = false {
        didSet{
            onLoading(isLoading)
        }
    }
    
    func getWeather(latitude:Double, longitude:Double){
        isLoading = true
        WeatherManager.shared.getWeatherDetails(latitude: latitude, longitude: longitude) { result in
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.weatherData = response
                    self.onCurrentWeather()
                case .failure(let failure):
                    switch failure {
                    case .error(error: let message):
                        self.onError(message)
                    default:
                        self.onError("Can't load data from server, please try again later")
                    }
                }
            }
    }
}
