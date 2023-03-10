#MiWeather

##Overview

Weather app allows users to check the weather for any city added in their favorite.
All cities that are saved to CoreData are listed in the main view controller.

This app uses MIWeatherFramework that provide weather information from any given location using OpenWeatherMap API.

Language: Swift
Design Pattern: MVVM


#Resources

Weather API: https://openweathermap.org/api

#Setup

You need to replace you unique API Key for OpenWeatherMap API in the following static property of the MIWeatherFramework `Constants` struct apiKey. This projects needs no additional setup.

```swift
    static let apiKey:String =  "ENTER_YOUR_API_KEY_"
```


## License
**Weather App** is available under the [MIT License](https://github.com/m-ahmadian/Weather-App/blob/master/LICENSE).
