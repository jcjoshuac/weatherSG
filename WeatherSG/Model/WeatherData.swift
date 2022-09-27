//
//  WeatherData.swift
//  WeatherSG
//
//  Created by Joshua on 5/6/20.
//  Copyright © 2020 Joshua. All rights reserved.
//

import Foundation

// Structured according to the JSON produced by the API

struct WeatherData: Codable {
    let items: [Item]
}

struct Item: Codable {
    let forecasts: [Area]
}

struct Area: Codable {
    let area: String
    let forecast: String
}
