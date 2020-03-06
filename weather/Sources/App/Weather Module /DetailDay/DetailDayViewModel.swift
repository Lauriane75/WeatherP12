//
//  DetailWeatherDayViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol DetailDayViewModelDelegate: class {
    func displayWeatherAlert(for type: AlertType)
}

final class DetailDayViewModel {

    // MARK: - Properties

    private let repository: WeatherRepositoryType

    private weak var delegate: DetailDayViewModelDelegate?

    private var selectedWeatherItem: WeatherItem

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: DetailDayViewModelDelegate?, selectedWeatherItem: WeatherItem) {
        self.repository = repository
        self.delegate = delegate
        self.selectedWeatherItem = selectedWeatherItem
    }

    // MARK: - Outputs

    var visibleItems: (([WeatherItem]) -> Void)?

    var cityText: ((String) -> Void)?

    var tempText: ((String) -> Void)?

    var descriptionText: ((String) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        cityText?("\(selectedWeatherItem.time)")
        tempText?("\(selectedWeatherItem.temperature)")
        descriptionText?("\(selectedWeatherItem.description.firstCapitalized)")
        showWeatherOfTheDay()
    }

    // MARK: - Private Files

    fileprivate func showWeatherOfTheDay() {
        repository.getWeatherItems { [weak self] (items) in
            guard let self = self else { return }
            guard items != [] else {
                self.delegate?.displayWeatherAlert(for: .errorService)
                return
            }
            self.visibleItems?(items.filter { $0.time.contains(self.selectedWeatherItem.time.dayFormat) })
        }
    }
}
