//
//  WeatherRepository.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import CoreData

protocol WeatherRepositoryType: class {

    // MARK: - Non unique city
    func containsCity(for city: CityItem) -> Bool

    // MARK: - Get from openWeather API
    func getCityWeather(nameCity: String, country: String, callback: @escaping (Result<WeatherOrigin>) -> Void)

    // MARK: - Save in coredata
    func saveCityItem(city: CityItem)
    func saveWeatherItem(weatherItem: WeatherItem)

    // MARK: - Get from coredata
    func getCityItems(callback: @escaping ([CityItem]) -> Void)
    func getWeatherItems(callback: @escaping ([WeatherItem]) -> Void)

    // MARK: - Delete from coredata
    func deleteWeatherItemInDataBase(timeWeather: String)
    func deleteCityItemInDataBase(nameCity: String)

}

enum WeatherOrigin {
    case web([WeatherItem])
    case noService([WeatherItem])
}

final class WeatherRepository: WeatherRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType
    private let token = RequestCancelationToken()
    private let stack: CoreDataStack

    private var cityItems: [CityObject] = []

    private var weatherItems: [WeatherObject] = []

    // MARK: - Initializer

    init(client: HTTPClientType, stack: CoreDataStack) {
        self.client = client
        self.stack = stack
    }

    // MARK: - Non unique city

    func containsCity(for city: CityItem) -> Bool {
          let requestCity: NSFetchRequest<CityObject> = CityObject.fetchRequest()
          guard let cityItems = try? stack.context.fetch(requestCity) else { return false }
          self.cityItems = cityItems
          let cities: [CityItem] = cityItems.map { return CityItem(object: $0) }
          return cities.contains(where: {
              $0.nameCity == city.nameCity.lowercased() &&
              $0.country == city.country.lowercased()
          })
      }

    // MARK: - Get from openWeather API

    func getCityWeather(nameCity: String, country: String, callback: @escaping (Result<WeatherOrigin>) -> Void) {
        let stringUrl = "http://api.openweathermap.org/data/2.5/forecast?q=\(nameCity),\(country)&units=metric&APPID=916792210f24330ed8b2f3f603669f4d"

        guard let url = URL(string: stringUrl) else { return }
        client.request(type: Weather.self,
                       requestType: .GET,
                       url: url,
                       cancelledBy: token) { weather in

                        switch weather {

                        case .success(value: let weatheritems):
                            let items: [WeatherItem] = weatheritems.forecasts.map { item in
                                let cityItem = weatheritems.city
                                return WeatherItem(weatherItem: item, cityItem: cityItem) }
                            callback(.success(value: .web(items)))

                        case .error(error: let error):
                            let requestWeather: NSFetchRequest<WeatherObject> = WeatherObject.fetchRequest()
                            if let weather = try? self.stack.context.fetch(requestWeather) {
                                let items: [WeatherItem] = weather.map {
                                    return WeatherItem(object: $0) }
                                callback(.success(value: .noService(items)))
                            } else {
                                callback(.error(error: error))
                            }
                        }
        }
    }

    // MARK: - Save in coredata

    func saveWeatherItem(weatherItem: WeatherItem) {
        let weatherObject = WeatherObject(context: stack.context)
        weatherObject.nameCityWeather = weatherItem.nameCity
        weatherObject.iconWeather = weatherItem.iconID
        weatherObject.timeWeather = weatherItem.time
        weatherObject.tempMinWeather = weatherItem.temperatureMin
        weatherObject.tempMaxWeather = weatherItem.temperatureMax
        weatherObject.tempWeather = weatherItem.temperature
        weatherObject.pressureWeather = weatherItem.pressure
        weatherObject.humidityWeather = weatherItem.humidity
        weatherObject.feelsLikeWeather = weatherItem.feelsLike
        weatherObject.descriptionWeather = weatherItem.description
        stack.saveContext()
    }

    func saveCityItem(city: CityItem) {
        let cityObject = CityObject(context: stack.context)
        cityObject.nameCity = city.nameCity
        cityObject.countryCity = city.country

        stack.saveContext()
    }

    // MARK: - Get from coredata

    func getWeatherItems(callback: @escaping ([WeatherItem]) -> Void) {
        let requestWeather: NSFetchRequest<WeatherObject> = WeatherObject.fetchRequest()
        guard let weatherItems = try? stack.context.fetch(requestWeather) else { return }
        let weather: [WeatherItem] = weatherItems.map { return WeatherItem(object: $0) }
        callback(weather)
    }

    func getCityItems(callback: @escaping ([CityItem]) -> Void) {
        let requestCity: NSFetchRequest<CityObject> = CityObject.fetchRequest()
        guard let cityItems = try? stack.context.fetch(requestCity) else { return }
        self.cityItems = cityItems
        let city: [CityItem] = cityItems.map { return CityItem(object: $0) }
        callback(city)
    }

    // MARK: - Delete from coredata

    func deleteWeatherItemInDataBase(timeWeather: String) {
        guard let object = weatherItems.first(where: { $0.timeWeather == timeWeather }) else {
            return }
        stack.context.delete(object)
        stack.saveContext()
    }

    func deleteCityItemInDataBase(nameCity: String) {
        guard let object = cityItems.first(where: { $0.nameCity == nameCity }) else { return }
        stack.context.delete(object)
        stack.saveContext()
    }
}

extension WeatherItem {
    init(object: WeatherObject) {
        self.nameCity = object.nameCityWeather ?? ""
        self.iconID = object.iconWeather ?? ""
        self.time = object.timeWeather ?? ""
        self.temperatureMin = object.tempMinWeather ?? ""
        self.temperatureMax = object.tempMaxWeather ?? ""
        self.temperature = object.tempWeather ?? ""
        self.pressure = object.pressureWeather ?? ""
        self.humidity = object.humidityWeather ?? ""
        self.feelsLike = object.feelsLikeWeather ?? ""
        self.description = object.descriptionWeather ?? ""
    }
}

extension CityItem {
    init(object: CityObject) {
        self.nameCity = object.nameCity?.lowercased() ?? ""
        self.country = object.countryCity?.lowercased() ?? ""
    }
}

extension WeatherItem {
    init(weatherItem: Forecast, cityItem: City) {
        self.nameCity = cityItem.name
        self.time = weatherItem.dtTxt
        self.temperature = "\(Int(weatherItem.main.temp)) °C"
        self.iconID = weatherItem.weather.first?.icon ?? "01d"
        self.temperatureMin = "\(Int(weatherItem.main.tempMin)) °C"
        self.temperatureMax = "\(Int(weatherItem.main.tempMax)) °C"
        self.pressure = "\(weatherItem.main.pressure) hPa"
        self.humidity = "\(weatherItem.main.humidity) %"
        self.feelsLike = "\(Int(weatherItem.main.feelsLike)) °C"
        self.description = "\(weatherItem.weather.first?.weatherDescription ?? "")"
    }
}
