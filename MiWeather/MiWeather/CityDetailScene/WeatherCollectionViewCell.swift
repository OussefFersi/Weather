//
//  WeatherCollectionViewCell.swift
//  MiWeather
//
//  Created by oussef on 09/03/2023.
//

import UIKit
import MIWeatherFramework
class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherStateIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellView(hourly:Hourly){
        let date = Date(timeIntervalSince1970: Double(hourly.dt))
        let hourString = date.getHour()
        self.timeLabel.text = hourString
        self.tempLabel.text = String(format: "%.1f°C", hourly.temp)
        let weather = hourly.weather[0]
        self.weatherStateIcon.image = UIImage(named: weather.icon)
    }
    
    func setCellView(daily:Daily){
        let date = Date(timeIntervalSince1970: Double(daily.dt))
        let dayString = date.getDayOfWeek()
        self.timeLabel.text = dayString
        self.tempLabel.text = daily.weather.first?.description ?? ""
        if let weather = daily.weather.first {
            self.weatherStateIcon.image = UIImage(named: weather.icon)
        }
       
    }

}
