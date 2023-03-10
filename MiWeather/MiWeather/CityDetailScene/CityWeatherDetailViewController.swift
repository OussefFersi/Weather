//
//  CityWeatherDetailViewController.swift
//  MiWeather
//
//  Created by oussef on 09/03/2023.
//

import UIKit

class CityWeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempratureLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var forecastWeatherTypeSC: UISegmentedControl!
    var city:City?
    
    var viewModel:CityWeatherDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        
        
        
        viewModel = CityWeatherDetailViewModel()
        
        viewModel?.onLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if(isLoading){
                    self?.activityLoader?.startAnimating()
                }else{
                    self?.activityLoader?.stopAnimating()
                }
                
            }
        }
        
        if let city = city {
            viewModel?.getWeather(latitude: city.latitude, longitude: city.longitude)
        }
        
        
        
        viewModel?.onCurrentWeather = { [weak self] in
            DispatchQueue.main.async {
                self?.setView()
                self?.collectionView.reloadData()
            }
        }
        
        
    }
    
    func setView(){
            self.cityNameLabel.text = self.city?.name
            if let temp = self.viewModel?.weatherData?.current.temp {
                self.currentTempratureLabel.text = String(format: "%.1f°C", temp)
            }
            if let weatherDescription = self.viewModel?.weatherData?.current.weather[0].description.capitalized {
                self.weatherStateLabel.text = weatherDescription
            }
            if let icon = self.viewModel?.weatherData?.current.weather[0].icon{
                self.currentWeatherIcon.image = UIImage(named: icon)
            }
    }

    @IBAction func controlSegmentAction(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
}
extension CityWeatherDetailViewController: UICollectionViewDelegate {
    
}

extension CityWeatherDetailViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(forecastWeatherTypeSC.selectedSegmentIndex == 0){
            //Hours
            return viewModel?.weatherData?.hourly.count ?? 0
        }else{
            //Days
            return viewModel?.weatherData?.daily.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell {
            
            if(forecastWeatherTypeSC.selectedSegmentIndex == 0){
                //Hourly
                let hourlyItem = viewModel?.weatherData?.hourly[indexPath.row]
                cell.setCellView(hourly: hourlyItem!)
            }else{
                //Daily
                let dailyItem = viewModel?.weatherData?.daily[indexPath.row]
                cell.setCellView(daily: dailyItem!)
            }

            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

