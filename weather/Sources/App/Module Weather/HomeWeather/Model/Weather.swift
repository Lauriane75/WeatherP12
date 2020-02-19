//
//  Weather.swift
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Forecast

struct Weather: Codable {
    let forecasts: [Forecast]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case forecasts = "list"
        case city
    }
}

// MARK: - ForecastCity

struct City: Codable {
    let name: String
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

// MARK: - ForecastList

struct Forecast: Codable {
    let dt: Int
    let main: ForecastMainClass
    let weather: [ForecastWeather]
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case dtTxt = "dt_txt"
    }
}

// MARK: - ForecastMainClass

struct ForecastMainClass: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}

// MARK: - ForecastWeather

struct ForecastWeather: Codable {
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}
