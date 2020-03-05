//
//  CityListViewModelTests.swift
//  weatherTests
//
//  Created by Lauriane Haydari on 05/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest
@ testable import weather

// MARK: - Mock

class MockCityListViewModelDelegate: CityListViewModelDelegate {

    var alert: AlertType?

    var weatherItem: WeatherItem?

    func didSelectCity(item: WeatherItem) {
        self.weatherItem = item
    }

    func displayAlert(for type: AlertType) {
        self.alert = type
    }
}

// MARK: - Tests

class CityListViewModelTests: XCTestCase {

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

    let cityItem = CityItem(nameCity: "fr", country: "paris")

    let delegate = MockCityListViewModelDelegate()
    let repository = MockWeatherRepository()

    func test_Given_ViewModel_When_ViewDidLoad_Then_visibleItemsAreDiplayed() {
        repository.weatherItems = [self.weatherItem]
        repository.cityItems = [self.cityItem]

        let viewModel = CityListViewModel(repository: repository, delegate: delegate)

        let expectation = self.expectation(description: "Diplayed visibleItems")

        viewModel.visibleWeatherItems = { items in
            XCTAssertEqual(items, [self.weatherItem])
            expectation.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_isLoadingIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        repository.cityItems = [self.cityItem]

        let viewModel = CityListViewModel(repository: repository, delegate: delegate)

        let expectation = self.expectation(description: "Diplayed activityIndicator network")

        var counter = 0

        viewModel.isLoading = { state in
            if counter == 1 {
                XCTAssertFalse(state)
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_didSelectCity_Then_expectedResult() {
        repository.weatherItems = [self.weatherItem]
        repository.cityItems = [self.cityItem]

        let viewModel = CityListViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()
        viewModel.didSelectCity(at: 0)

        XCTAssertEqual(delegate.weatherItem, self.weatherItem)
    }

    func test_Given_ViewModel_When_didPressDelete_Then_expectedResult() {
        repository.weatherItems = [self.weatherItem]
        repository.cityItems = [self.cityItem]

        let viewModel = CityListViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()
        viewModel.didPressDeleteCity(at: 0)

        XCTAssertEqual(delegate.weatherItem, nil)
    }

}
