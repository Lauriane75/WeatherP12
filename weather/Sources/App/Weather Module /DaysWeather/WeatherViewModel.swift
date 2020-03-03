//
//  WeatherViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol WeatherViewModelDelegate: class {
    func didSelect(item: WeatherItem)
    func displayWeatherAlert(for type: AlertType)
}

final class WeatherViewModel {
    
    // MARK: - Properties
    
    private let repository: WeatherRepositoryType
    
    private weak var delegate: WeatherViewModelDelegate?
    
    private var weatherItems: [WeatherItem] = [] {
        didSet {
            self.visibleItems?(self.weatherItems)
        }
    }
    
    private let timeWeatherDay = "12:00:00"
    
    // MARK: - Initializer
    
    init(repository: WeatherRepositoryType, delegate: WeatherViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
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
        cityText?("Paris")
        nowText?("Now")
        showFiveDaysWeather()
    }
    
    func didSelectWeatherDay(at index: Int) {
        guard !self.weatherItems.isEmpty, index < self.weatherItems.count else { return }
        let item = self.weatherItems[index]
        self.delegate?.didSelect(item: item)
    }
    
    // MARK: - Private Files
    
    fileprivate func showFiveDaysWeather() {
        isLoading?(true)
        repository.getWeather(callback: { [weak self] weather in
            guard let self = self else { return }
            self.isLoading?(false)
            switch weather {
            case .success(value: let items):
                guard !items.isEmpty else {
                    self.delegate?.displayWeatherAlert(for: .errorService)
                    return
                }
                self.displayHeaderLabels(items)
                self.initialize(items: items)
                self.deleteInDataBase(items)
                self.saveInDataBase(items)
                guard !items.isEmpty else {
                    self.delegate?.displayWeatherAlert(for: .errorService)
                    return
                }
                self.displayHeaderLabels(items)
                self.initialize(items: items)
            case .error:
                self.delegate?.displayWeatherAlert(for: .errorService)
            }
        })
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
            let iconNow = items.first?.iconID
            else { return }
        tempText?("\(tempNow)")
        iconText?("\(iconNow)" )
    }
    
    private func saveInDataBase(_ items: ([WeatherItem])) {
        DispatchQueue.main.async {
            items.enumerated().forEach { _, index in
                self.repository.saveWeatherItems(items: index)
            }
        }
    }
    
    private func deleteInDataBase(_ items: ([WeatherItem])) {
        DispatchQueue.main.async {
            items.enumerated().forEach { _, index in
                self.repository.deleteInDataBase(timeWeather: index.time)
            }
        }
    }
}
