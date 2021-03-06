//
//  DetailWeatherDayViewModelTests.swift
//  weatherTests
//
//  Created by Lauriane Haydari on 13/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest
@ testable import weather

// MARK: - Mock

final class MockDetailDayViewModelDelegate: DetailDayViewModelDelegate {

    var alert: AlertType?

    func displayWeatherAlert(for type: AlertType) {
        self.alert = type
    }
}

// MARK: - Tests

class DetailDayViewModelTests: XCTestCase {

    let delegate = MockDetailDayViewModelDelegate()
    let repository = MockWeatherRepository()

    let weatherItem = WeatherItem(nameCity: "paris",
                                     time: "2020-02-13 12:00:00",
                                     temperature: "19 °C",
                                     iconID: "01d",
                                     temperatureMax: "20 °C",
                                     temperatureMin: "15 °C",
                                     pressure: "1002 hPa",
                                     humidity: "50 %",
                                     feelsLike: "18 °C",
                                     description: "Sunny")

    func test_Given_DetailViewModel_When_ViewdidLoad_Then_visibleItemsIsDisplayed() {
        repository.saveWeatherItem(weatherItem: weatherItem)
        repository.weatherItems = [weatherItem]
        let viewModel = DetailDayViewModel(repository: repository,
                                                  delegate: delegate,
                                                  selectedWeatherItem: weatherItem)

        viewModel.visibleItems = { items in
            XCTAssertEqual(items[0], self.weatherItem)
        }

        viewModel.viewDidLoad()
    }

    func test_Given_DetailViewModel_When_ViewdidLoad_Then_cityTextIsDisplayed() {
        let viewModel = DetailDayViewModel(repository: repository,
                                                  delegate: delegate,
                                                  selectedWeatherItem: weatherItem)

        viewModel.navBarTitle = { item in
            XCTAssertEqual(item, self.weatherItem.time.dayPlainTextFormat)
        }

        viewModel.viewDidLoad()
    }

    func test_Given_DetailViewModel_When_ViewdidLoad_Then_tempTextIsDisplayed() {
        let viewModel = DetailDayViewModel(repository: repository,
                                                  delegate: delegate,
                                                  selectedWeatherItem: weatherItem)

        viewModel.tempText = { item in
            XCTAssertEqual(item, self.weatherItem.temperature)
        }

        viewModel.viewDidLoad()
    }

    func test_Given_DetailViewModel_When_ViewdidLoad_Then_descriptionTextIsDisplayed() {
        let viewModel = DetailDayViewModel(repository: repository,
                                                  delegate: delegate,
                                                  selectedWeatherItem: weatherItem)

        viewModel.descriptionText = { item in
            XCTAssertEqual(item, self.weatherItem.description)
        }

        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_noItems_Then_alert() {
        repository.weatherItems = []
        let viewModel = DetailDayViewModel(repository: repository,
                                                  delegate: delegate,
                                                  selectedWeatherItem: weatherItem)

        viewModel.viewDidLoad()

        XCTAssertEqual(delegate.alert, .errorService)
    }
}
