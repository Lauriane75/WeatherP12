//
//  MockWeatherRepository.swift
//  weatherTests
//
//  Created by Lauriane Haydari on 05/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation
@ testable import weather

class MockWeatherRepository: WeatherRepositoryType {

    var weatherItems: [WeatherItem]?
    var cityItems: [CityItem]?

    var isSuccess = true
    var isFromWeb = true

    var weatherOrigin: WeatherOrigin!
    var error: Error!

    func getCityWeather(nameCity: String, country: String, callback: @escaping (Result<WeatherOrigin>) -> Void) {
        if let weatherItems = weatherItems {
            callback(.success(value: isFromWeb ? .web(weatherItems) : .database(weatherItems)))
        } else if isSuccess == false {
            callback(.error(error: error))
        }
    }

    func saveCityItem(city: CityItem) {

    }

    func saveWeatherItem(weatherItem: WeatherItem) {

    }

    func getCityItems(callback: @escaping ([CityItem]) -> Void) {
        guard cityItems != nil else { return }
        callback(cityItems!)
    }

    func getWeatherItems(callback: @escaping ([WeatherItem]) -> Void) {
        guard weatherItems != nil else { return }
        callback(weatherItems!)
    }

    func deleteWeatherItemInDataBase(timeWeather: String) {

    }

    func deleteCityItemInDataBase(nameCity: String) {

    }
}
