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
                    case .success(value: let weatherItems):
                        guard !weatherItems.isEmpty else {
                            self.delegate?.displayAlert(for: .errorService)
                            return
                        }
                        self.initialize(weatherItems: weatherItems)
                        guard !weatherItems.isEmpty else {
                            self.delegate?.displayAlert(for: .errorService)
                            return
                        }
                    case .error:
                        self.delegate?.displayAlert(for: .errorService)
                    }
                })
            }
        }
    }

    private func initialize(weatherItems: [WeatherItem]) {
        let weatherItems = weatherItems.first
        guard weatherItems != nil else {
            self.delegate?.displayAlert(for: .errorService)
            return
        }
        self.weatherItems.append(weatherItems!)
    }
}
