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
        nowText?("Now")
        showWeekWeather()
    }

    func didSelectWeatherDay(at index: Int) {
        guard !self.weatherItems.isEmpty, index < self.weatherItems.count else { return }
        let item = self.weatherItems[index]
        self.delegate?.didSelectDay(item: item)
    }

    // MARK: - Private Files

    fileprivate func showWeekWeather() {
        isLoading?(true)
        repository.getWeatherItems { [weak self] (items) in
            print("item = \(items)")
            guard let self = self else { return }
            self.isLoading?(false)
            self.displayHeaderLabels(items)
            self.initialize(items: items)
        }
    }

    private func initialize(items: [WeatherItem]) {
        let items = items.filter { $0.time.contains(self.timeWeatherDay) }
        if items.isEmpty {
            self.delegate?.displayWeatherAlert(for: .errorService)
        }
        weatherItems = items
    }

    private func displayHeaderLabels(_ items: ([WeatherItem])) {
        guard
            let tempNow = items.first?.temperature,
            let iconNow = items.first?.iconID,
            let city = items.first?.nameCity
            else { return }
        tempText?("\(tempNow)")
        iconText?("\(iconNow)" )
        cityText?("\(city)")
    }

//    private func saveInDataBase(_ items: ([WeatherItem])) {
//        DispatchQueue.main.async {
//            items.enumerated().forEach { _, index in
//                self.repository.saveWeatherItem(weatherItem: index)
//            }
//        }
//    }
//
//    private func deleteInDataBase(_ items: ([WeatherItem])) {
//        DispatchQueue.main.async {
//            items.enumerated().forEach { _, index in
//                self.repository.deleteWeatherItemsInDataBase(timeWeather: index.time)
//            }
//        }
//    }
}
