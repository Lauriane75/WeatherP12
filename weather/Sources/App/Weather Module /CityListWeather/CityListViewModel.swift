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

    private var weatherItems: [WeatherItem] = [] {
        didSet {
            self.visibleItems?(self.weatherItems)
        }
    }

    private let timeWeatherDay = "12:00:00"

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: CityListViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Output

    var visibleItems: (([WeatherItem]) -> Void)?

    var isLoading: ((Bool) -> Void)?

    // MARK: - Input

    func viewDidLoad() {
        showFiveDaysWeather()
    }

    func didSelectCity(at index: Int) {
        guard !self.weatherItems.isEmpty, index < self.weatherItems.count else { return }
        let item = self.weatherItems[index]
        self.delegate?.didSelectCity(item: item)
    }

    // MARK: - Private Functions

    fileprivate func showFiveDaysWeather() {
        isLoading?(true)
//        repository.getCityWeather(nameCity: nameCity, country: country, callback: { [weak self] weather in
        repository.getWeather(callback: { [weak self] weather in
            guard let self = self else { return }
            self.isLoading?(false)
            switch weather {
            case .success(value: let items):
                guard !items.isEmpty else {
                    self.delegate?.displayAlert(for: .errorService)
                    return
                }
                self.initialize(items: items)
                guard !items.isEmpty else {
                    self.delegate?.displayAlert(for: .errorService)
                    return
                }
            case .error:
                self.delegate?.displayAlert(for: .errorService)
            }
        })
    }

    private func initialize(items: [WeatherItem]) {
        let items = items.filter { $0.time.contains(self.timeWeatherDay) }
        if items.isEmpty {
            self.delegate?.displayAlert(for: .errorService)
        }
        weatherItems = items
    }
}
