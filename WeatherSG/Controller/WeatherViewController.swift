//
//  ViewController.swift
//  WeatherSG
//
//  Created by Joshua on 5/6/20.
//  Copyright © 2020 Joshua. All rights reserved.
//
//  Description: WeatherSG provides real-time weather forecasts for locations within Singapore
//  To-do List: 1) Add more locations within Singapore 2) Add more functionality such as 24-hour forecasts
//  References: Clima app from Udemy's iOS 13 & Swift 5 - The Complete iOS App Development Bootcamp by Angela Yu
//  API: https://data.gov.sg/dataset/weather-forecast
//  Search https://colorhunt.co for good dark blue and light blue colours for the app background

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var oneAreaLabel: UILabel!
    @IBOutlet weak var oneForecastLabel: UILabel!
    @IBOutlet weak var twoAreaLabel: UILabel!
    @IBOutlet weak var twoForecastLabel: UILabel!
    @IBOutlet weak var threeAreaLabel: UILabel!
    @IBOutlet weak var threeForecastLabel: UILabel!
    @IBOutlet weak var fourAreaLabel: UILabel!
    @IBOutlet weak var fourForecastLabel: UILabel!
    @IBOutlet weak var fiveAreaLabel: UILabel!
    @IBOutlet weak var fiveForecastLabel: UILabel!
    //@IBOutlet weak var dateTextField: UITextField!
    
    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        //dateTextField.delegate = self
        
        let now = Date() // Get the current datetime information
        let formatter = ISO8601DateFormatter() // ISO 8601 date/time format
        let datetime = formatter.string(from: now) // Output: 2020-03-13T14:29:52Z
        weatherManager.fetchWeather(datetime: datetime)
    }
}

//MARK: - UITextFieldDelegate
/*
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        dateTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type a date in YYYY-MM-DD format"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let datetime = dateTextField.text {
            weatherManager.fetchWeather(datetime: datetime)
        }
        
        dateTextField.text = ""
        
    }
}
*/
//MARK: - WeatherManagerDelegate


extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.oneAreaLabel.text = weather.oneArea
            self.oneForecastLabel.text = weather.oneForecast
            self.twoAreaLabel.text = weather.twoArea
            self.twoForecastLabel.text = weather.twoForecast
            self.threeAreaLabel.text = weather.threeArea
            self.threeForecastLabel.text = weather.threeForecast
            self.fourAreaLabel.text = weather.fourArea
            self.fourForecastLabel.text = weather.fourForecast
            self.fiveAreaLabel.text = weather.fiveArea
            self.fiveForecastLabel.text = weather.fiveForecast
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
