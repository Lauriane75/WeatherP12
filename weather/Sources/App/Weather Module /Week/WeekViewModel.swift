//
//  WeatherViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeekViewModelDelegate: class {
    func didSelectDay(item: WeatherItem)
    func displayWeatherAlert(for type: AlertType)
}

final class WeekViewModel {

    // MARK: - Properties

    private let repository: WeatherRepositoryType

    private weak var delegate: WeekViewModelDelegate?

    private var selectedWeatherItem: WeatherItem

    private var weatherItems: [WeatherItem] = [] {
        didSet {
            self.visibleItems?(self.weatherItems)
        }
    }

    private let timeWeatherDay = "12:00:00"

    private var nameCity = ""

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: WeekViewModelDelegate?, selectedWeatherItem: WeatherItem) {
        self.repository = repository
        self.delegate = delegate
        self.selectedWeatherItem = selectedWeatherItem
    }

    // MARK: - Outputs

    var cityText: ((String) -> Void)?

    var nowText: ((String) -> Void)?

    var visibleItems: (([WeatherItem]) -> Void)?

    var tempText: ((String) -> Void)?

    var iconText: ((String) -> Void)?

    var isLoading: ((Bool) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        isLoading?(true)
        nowText?("Now")
        getCityItemsSelected()
        showWeekWeather()
    }

    func didSelectWeatherDay(at index: Int) {
        guard !self.weatherItems.isEmpty, index < self.weatherItems.count else { return }
        let item = self.weatherItems[index]
        self.delegate?.didSelectDay(item: item)
    }

    // MARK: - Private Files

    fileprivate func showWeekWeather() {
         repository.getWeatherItems { [weak self] (items) in
             guard let self = self else { return }
            self.isLoading?(false)
             guard items != [] else {
                 self.delegate?.displayWeatherAlert(for: .errorService)
                 return
             }
            self.displayHeaderLabels(items)
            self.initialize(items: items)
         }
     }

    private func initialize(items: [WeatherItem]) {
        let weatherItemsOfTheCity = items.filter { $0.nameCity.contains(self.nameCity) }
        let items = weatherItemsOfTheCity.filter { $0.time.contains(self.timeWeatherDay) }
        if items.isEmpty {
            self.delegate?.displayWeatherAlert(for: .errorService)
        }
        weatherItems = items
    }

    private func displayHeaderLabels(_ items: ([WeatherItem])) {

        let weatherItemsOfTheCity = items.filter { $0.nameCity.contains(self.nameCity) }

        guard
            let tempNow = weatherItemsOfTheCity.first?.temperature,
            let iconNow = weatherItemsOfTheCity.first?.iconID,
            let city = weatherItemsOfTheCity.first?.nameCity
            else { return }
        tempText?("\(tempNow)")
        iconText?("\(iconNow)" )
        cityText?("\(city)")
    }

    private func deleteInDataBase(_ items: ([WeatherItem])) {
        DispatchQueue.main.async {
            items.enumerated().forEach { _, index in
                self.repository.deleteWeatherItemInDataBase(timeWeather: index.time)
            }
        }
    }

    private func getCityItemsSelected() {
        self.nameCity = self.selectedWeatherItem.nameCity
    }
}
