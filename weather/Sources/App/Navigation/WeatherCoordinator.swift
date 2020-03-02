//
//  WeatherCoordinator.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class WeatherCoordinator {

    // MARK: - Properties

    private let presenter: UINavigationController

    private let screens: Screens

    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }

    // MARK: - Coodinator

    func start() {
        showHome()
    }

    private func showHome() {
        let viewController = screens.createCityViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }

    private func showDaysWeather() {
        let viewController = screens.createDaysWeatherViewController(delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }

    private func showWeatherDayDetail(weatherDay: WeatherItem) {
        let viewController = screens.createWeatherDetailViewController(selectedWeatherItem: weatherDay, delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }

    private func showAlert(for type: AlertType) {
        let alert = screens.createAlertView(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension WeatherCoordinator: CityListViewModelDelegate {
    func didSelectCity(item: WeatherItem) {
        showDaysWeather()
    }
    func displayAlert(for type: AlertType) {

    }

}

extension WeatherCoordinator: WeatherViewModelDelegate {
    func displayWeatherAlert(for type: AlertType) {
        DispatchQueue.main.async {
            self.showAlert(for: type)
        }
    }

    func didSelect(item: WeatherItem) {
        showWeatherDayDetail(weatherDay: item)
    }
}

extension WeatherCoordinator: DetailWeatherDayViewModelDelegate {
    // To do: - Would implement this later
}
