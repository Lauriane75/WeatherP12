//
//  WeahterViewModelTests.swift
//  weatherTests
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest
@ testable import weather

// MARK: - Mock

class MockWeekViewModelDelegate: WeekViewModelDelegate {

    var alert: AlertType?

    var weatherItem: WeatherItem?

    func didSelectDay(item: WeatherItem) {
        self.weatherItem = item
    }

    func displayWeatherAlert(for type: AlertType) {
        self.alert = type
    }
}

// MARK: - Tests

class WeekViewModelTests: XCTestCase {

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

    let delegate = MockWeekViewModelDelegate()
    let repository = MockWeatherRepository()

    func test_Given_ViewModel_When_ViewDidLoad_Then_cityTextIsDiplayed() {
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.cityText = { text in
            XCTAssertEqual(text, "Paris")
        }

        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewDidLoad_Then_nowTextIsDiplayed() {
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.nowText = { text in
            XCTAssertEqual(text, "Now")
        }

        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_Then_visibleItemsAreDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed visibleItems with network")

        viewModel.visibleItems = { items in
            XCTAssertEqual(items, [self.weatherItem])
            expectation.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithoutNetwork_Then_visibleItemsAreDiplayedFromDatabase() {
        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed visibleItems without network")

        viewModel.visibleItems = { items in
            XCTAssertEqual(items, [self.weatherItem])
            expectation.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_Then_tempTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed tempText with network")

        viewModel.tempText = { text in
            XCTAssertEqual(text, "19 °C")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithoutNetwork_Then_tempTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed tempText without network")

        viewModel.tempText = { text in
            XCTAssertEqual(text, "19 °C")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_Then_iconTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed iconText with network")

        viewModel.iconText = { text in
            XCTAssertEqual(text, "01d")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithoutNetwork_Then_iconTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed iconText without network")

        viewModel.iconText = { text in
            XCTAssertEqual(text, "01d")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_Then_isLoadingIsDiplayed() {
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.viewDidLoad()

        viewModel.isLoading = { state in
            XCTAssertTrue(state)
        }
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_isLoadingIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed isLoading whith network")

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

    func test_Given_ViewModel_When_ViewDidLoad_WhithoutNetwork_isLoadingIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        let expectation = self.expectation(description: "Diplayed activityIndicator whithout network")

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

    func test_Given_ViewModel_When_didSelectWeatherDay_Then_expectedResult() {
        repository.weatherItems = [weatherItem]
        let delegate = MockWeekViewModelDelegate()

        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.viewDidLoad()
        viewModel.didSelectWeatherDay(at: 0)

        XCTAssertEqual(delegate.weatherItem, self.weatherItem)
    }

    func test_Given_ViewModel_When_noInternetConnection_Then_alert() {
        repository.isSuccess = false
        repository.error = ServiceError.noData
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.viewDidLoad()

        XCTAssertEqual(delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_noItems_Then_alert() {
        repository.weatherItems = []
        repository.isSuccess = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.viewDidLoad()

        XCTAssertEqual(delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_noItemsWithNetwork_Then_alert() {
        repository.weatherItems = []
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.viewDidLoad()

        XCTAssertEqual(self.delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_noItemsWithoutNetwork_Then_alert() {
        repository.isFromWeb = false
        repository.weatherItems = []
        let viewModel = WeekViewModel(repository: repository, delegate: delegate, selectedWeatherItem: weatherItem)

        viewModel.viewDidLoad()

        XCTAssertEqual(self.delegate.alert, .errorService)
    }
}
