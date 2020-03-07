//
//  CityListViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 02/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol CityListViewModelDelegate: class {
    func didSelectCity(item: WeatherItem)
    func displayAlert(for type: AlertType)
}

final class CityListViewModel {

    // MARK: - Properties

    private let repository: WeatherRepositoryType

    private weak var delegate: CityListViewModelDelegate?

    private let timeWeatherDay = "12:00:00"

    private var weatherItems: [WeatherItem] = [] {
        didSet {
            print(self.weatherItems)
            self.visibleWeatherItems?(self.weatherItems)
        }
    }

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: CityListViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var visibleWeatherItems: (([WeatherItem]) -> Void)?

    var isLoading: ((Bool) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        showCityListWeather()
    }

    func didSelectCity(at index: Int) {
        guard !self.weatherItems.isEmpty, index < self.weatherItems.count else { return }
        let item = self.weatherItems[index]
        self.delegate?.didSelectCity(item: item)
    }

    func didPressDeleteCity(at index: Int) {
        guard !self.weatherItems.isEmpty, index < self.weatherItems.count else { return }
        let item = self.weatherItems[index]
        repository.deleteWeatherItemInDataBase(timeWeather: item.time)
        repository.deleteCityItemInDataBase(nameCity: item.nameCity.lowercased())
        print(item.nameCity)
        weatherItems.remove(at: index)
    }

    // MARK: - Private Functions

    fileprivate func showCityListWeather() {
        isLoading?(true)
        repository.getCityItems { (cityItems) in
            guard !cityItems.isEmpty else { return }
            cityItems.enumerated().forEach { _, index in
                self.repository.getCityWeather(nameCity: index.nameCity, country: index.country, callback: { [weak self] weather in
                    guard let self = self else { return }
                    self.isLoading?(false)
                    switch weather {
                    case .success(value: let dataOrigin):
                        switch dataOrigin {
                        case .web(let items):
                            guard !items.isEmpty else {
                                self.delegate?.displayAlert(for: .errorService)
                                return
                            }
                            self.initializeWeather(weatherItems: items)
                        case .noService(let items):
                            guard !items.isEmpty else {
                                self.delegate?.displayAlert(for: .errorService)
                                return
                            }
                            self.initializeWeather(weatherItems: items)
                        }
                    case .error:
                        self.delegate?.displayAlert(for: .errorService)
                    }
                })
            }
        }
    }

    private func initializeWeather(weatherItems: [WeatherItem]) {
        let weatherItems = weatherItems.first
        guard weatherItems != nil else {
            self.delegate?.displayAlert(for: .errorService)
            return
        }
        self.weatherItems.append(weatherItems!)
    }

    private func saveWeatherInDataBase(_ items: ([WeatherItem])) {
        DispatchQueue.main.async {
            items.enumerated().forEach { _, index in
                self.repository.saveWeatherItem(weatherItem: index)
            }
        }
    }

    private func saveCityInDataBase(_ items: ([CityItem])) {
        DispatchQueue.main.async {
            items.enumerated().forEach { _, index in
                self.repository.saveCityItem(city: index)
            }
        }
    }
}
