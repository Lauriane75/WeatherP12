//
//  WeatherRepository.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import CoreData

protocol WeatherRepositoryType: class {
    func getWeather(callback: @escaping (Result<[WeatherItem]>) -> Void)
    func saveWeatherItems(items: WeatherItem)
    func getWeatherItems(callback: @escaping ([WeatherItem]) -> Void)
    func deleteInDataBase(timeWeather: String)
}

final class WeatherRepository: WeatherRepositoryType {

    // MARK: - Properties

    private let client: HTTPClientType
    private let token = RequestCancelationToken()
    private let stack: CoreDataStack

    // MARK: - Initializer

    init(client: HTTPClientType, stack: CoreDataStack) {
        self.client = client
        self.stack = stack
    }

    // MARK: - Get from openWeather API

    func getWeather(callback: @escaping (Result<[WeatherItem]>) -> Void) {
        let stringUrl = "http://api.openweathermap.org/data/2.5/forecast?q=Paris,fr&units=metric&APPID=916792210f24330ed8b2f3f603669f4d"

        guard let url = URL(string: stringUrl) else { return }
        client.request(type: Weather.self,
                       requestType: .GET,
                       url: url,
                       cancelledBy: token) { weather in

            switch weather {

            case .success(value: let weatheritems):
                let items: [WeatherItem] = weatheritems.forecasts.map { item in
                    return WeatherItem(item: item) }
                callback(.success(value: (items)))

            case .error(error: let error):
                let requestWeather: NSFetchRequest<WeatherObject> = WeatherObject.fetchRequest()
                if let weather = try? self.stack.context.fetch(requestWeather) {
                    let items: [WeatherItem] = weather.map {
                        return WeatherItem(object: $0) }
                    callback(.success(value: (items)))
                } else {
                    callback(.error(error: error))
                }
            }
        }
    }

    // MARK: - Save in coredata

    func saveWeatherItems(items: WeatherItem) {
        let weatherObject = WeatherObject(context: stack.context)
        weatherObject.iconWeather = items.iconID
        weatherObject.timeWeather = items.time
        weatherObject.tempMinWeather = items.temperatureMin
        weatherObject.tempMaxWeather = items.temperatureMax
        weatherObject.tempWeather = items.temperature
        weatherObject.pressureWeather = items.pressure
        weatherObject.humidityWeather = items.humidity
        weatherObject.feelsLikeWeather = items.feelsLike
        weatherObject.descriptionWeather = items.description
        stack.saveContext()
    }

    // MARK: - Get from coredata

    func getWeatherItems(callback: @escaping ([WeatherItem]) -> Void) {
        let requestWeather: NSFetchRequest<WeatherObject> = WeatherObject.fetchRequest()
        guard let weatherItems = try? stack.context.fetch(requestWeather) else { return }
        let weather: [WeatherItem] = weatherItems.map { return WeatherItem(object: $0) }
        callback(weather)
    }

    // MARK: - Delete from coredata

    func deleteInDataBase(timeWeather: String) {
        let request: NSFetchRequest<WeatherObject> = WeatherObject.fetchRequest()
        guard request.entityName != nil else { return }
        request.predicate = NSPredicate(format: "timeWeather == %@", timeWeather)

        if let object = try? stack.context.fetch(request), let firstObject = object.first {
            stack.context.delete(firstObject)
            stack.saveContext()
        }
    }
}

extension WeatherItem {
    init(object: WeatherObject) {
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

extension WeatherItem {
    init(item: Forecast) {
        self.time = item.dtTxt
        self.temperature = "\(Int(item.main.temp)) °C"
        self.iconID = item.weather.first?.icon ?? "01d"
        self.temperatureMin = "\(Int(item.main.tempMin)) °C"
        self.temperatureMax = "\(Int(item.main.tempMax)) °C"
        self.pressure = "\(item.main.pressure) hPa"
        self.humidity = "\(item.main.humidity) %"
        self.feelsLike = "\(Int(item.main.feelsLike)) °C"
        self.description = "\(item.weather.first?.weatherDescription ?? "")"
    }
}
