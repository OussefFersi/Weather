//
//  ListCitiesViewModel.swift
//  MiWeather
//
//  Created by oussef on 08/03/2023.
//

import Foundation

class ListCitiesViewModel: NSObject, CoreDataManagerDelegate {
    
    
    var cities = [City](){
        didSet{
            onCitiesReload(cities)
        }
    }
    
    var onCitiesReload:(_ items:[City]) -> () = { _ in }
    var onCityAdded: (City) -> () = { _ in }
    var onCityRemoved: (City) -> () = { _ in }
    
    override init(){
        super.init()
        loadCities()
        CoreDataManager.shared.delegate = self
    }
    
    func loadCities(){
        self.cities = CoreDataManager.shared.fetchCities()
    }
    
    func removeCity(city:City){
        CoreDataManager.shared.removeCity(city: city)
    }
    
    func onCMCityAdded() {
        loadCities()
    }
    
    func onCMCityRemoved() {
        loadCities()
    }
    

}
