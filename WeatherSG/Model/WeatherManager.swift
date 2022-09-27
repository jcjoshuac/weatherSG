//
//  WeatherManager.swift
//  WeatherSG
//
//  Created by Joshua on 5/6/20.
//  Copyright © 2020 Joshua. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    //let weatherURL = "https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date"
    let weatherURL = "https://api.data.gov.sg/v1/environment/2-hour-weather-forecast?date_time"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(datetime: String) {
        //let urlString = "\(weatherURL)=\(date)"
        let urlString = "\(weatherURL)=\(datetime)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        // Call didUpdateWeather function in WeatherViewController under WeatherManagerDelegate once JSON data has been parsed
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            for areaForecast in decodedData.items[0].forecasts {
                print(areaForecast.area)
                print(areaForecast.forecast)
            }
            
            let oneArea = decodedData.items[0].forecasts[12].area
            let oneForecast = decodedData.items[0].forecasts[12].forecast
            let twoArea = decodedData.items[0].forecasts[22].area
            let twoForecast = decodedData.items[0].forecasts[22].forecast
            let threeArea = decodedData.items[0].forecasts[25].area
            let threeForecast = decodedData.items[0].forecasts[25].forecast
            let fourArea = decodedData.items[0].forecasts[1].area
            let fourForecast = decodedData.items[0].forecasts[1].forecast
            let fiveArea = decodedData.items[0].forecasts[2].area
            let fiveForecast = decodedData.items[0].forecasts[2].forecast
            
            let weather = WeatherModel(oneArea: oneArea, oneForecast: oneForecast, twoArea: twoArea, twoForecast: twoForecast, threeArea: threeArea, threeForecast: threeForecast, fourArea: fourArea, fourForecast: fourForecast, fiveArea: fiveArea, fiveForecast: fiveForecast)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}

