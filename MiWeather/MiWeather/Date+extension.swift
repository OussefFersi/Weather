//
//  Date+extension.swift
//  MiWeather
//
//  Created by oussef on 09/03/2023.
//

import Foundation
extension Date {
     func getHour() -> String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
            dateFormatter.locale = Locale.current
            return dateFormatter.string(from: self)
        }
    
    func getDayOfWeek() -> String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .short
            dateFormatter.locale = Locale.current
            return dateFormatter.string(from: self)
        }
}
