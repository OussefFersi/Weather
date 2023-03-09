//
//  AddCityViewModel.swift
//  MiWeather
//
//  Created by oussef on 09/03/2023.
//

import MapKit

class AddCityViewModel: NSObject,MKLocalSearchCompleterDelegate {

    var onReloadData:(_ items:[MKLocalSearchCompletion]) -> () = { _ in }
    var onCityAdded:(_ item:City) -> () = { _ in }
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.region = MKCoordinateRegion(.world)
        searchCompleter.filterType = .locationsOnly
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            
        searchResults = completer.results.filter { result in
            if result.subtitle.isEmpty {
                return false
            }
            if result.title.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
                return false
            }

            if result.subtitle.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
                return false
            }

            return true
        }
        onReloadData(searchResults)
    }
        
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //empty
    }
    
    func restSearch(){
        searchResults.removeAll()
        onReloadData(searchResults)
    }
    
    func onSelectCity(cityResultItem:MKLocalSearchCompletion){
        let searchRequest = MKLocalSearch.Request(completion: cityResultItem)
         
         let search = MKLocalSearch(request: searchRequest)
         search.start { (response, error) in
             guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                 return
             }
             
             guard let name = response?.mapItems[0].name else {
                 return
             }

             let lat = coordinate.latitude
             let lon = coordinate.longitude
             CoreDataManager.shared.saveCity(name: name, lat: lat, long: lon) { success, error in
                 if success{
                     self.onCityAdded(City(name: name, longitude: lon, latitude: lat))
                 }
             }
         }
    }
    
}
