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

class MockWeatherViewModelDelegate: WeekViewModelDelegate {

    var alert: AlertType?

    var weatherItem: WeatherItem?

    func didSelectDay(item: WeatherItem) {
        self.weatherItem = item
    }

    func displayWeatherAlert(for type: AlertType) {
        self.alert = type
    }
}

class MockWeatherRepository: WeatherRepositoryType {
    func getCityItems(callback: @escaping ([String], [String]) -> Void) {

    }

    func getCityWeather(nameCity: String, country: String, callback: @escaping (Result<[WeatherItem]>) -> Void) {

    }

    func saveCityItems(nameCity: String, country: String) {

    }

    var weatherItems: [WeatherItem]?
    var isSuccess = true
    var isFromWeb = true
    var error: Error!

    func saveWeatherItems(weatherItem: WeatherItem) {

    }

    func getWeatherItems(callback: @escaping ([WeatherItem]) -> Void) {
        guard weatherItems != nil else { return }
        callback(weatherItems!)
    }

    func deleteWeatherItemsInDataBase(timeWeather: String) {

    }

    func getWeather(callback: @escaping (Result<[WeatherItem]>) -> Void) {
        if let weatherItems = weatherItems {
            callback(.success(value: (weatherItems)))
        } else if isSuccess == false {
            callback(.error(error: error))
        }
    }
}

// MARK: - Tests

class WeatherViewModelTests: XCTestCase {
    let weatherItem = WeatherItem(time: "2020-02-13 12:00:00",
                                  temperature: "19 °C",
                                  iconID: "01d",
                                  temperatureMax: "20 °C",
                                  temperatureMin: "15 °C",
                                  pressure: "1002 hPa",
                                  humidity: "50 %",
                                  feelsLike: "18 °C",
                                  description: "Sunny")

    let delegate = MockWeatherViewModelDelegate()
    let repository = MockWeatherRepository()

    func test_Given_ViewModel_When_ViewDidLoad_Then_cityTextIsDiplayed() {
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)

        viewModel.cityText = { text in
            XCTAssertEqual(text, "Paris")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewDidLoad_Then_nowTextIsDiplayed() {
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)

        viewModel.nowText = { text in
            XCTAssertEqual(text, "Now")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_Then_visibleItemsAreDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository,
                                         delegate: delegate)
        let expectation = self.expectation(description: "Diplayed visibleItems with network")
        var counter = 0

        viewModel.visibleItems = { items in
            if counter == 1 {
                XCTAssertEqual(items, [self.weatherItem])
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithoutNetwork_Then_visibleItemsAreDiplayedFromDatabase() {
        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false
        let viewModel = WeekViewModel(repository: repository,
                                         delegate: delegate)
        let expectation = self.expectation(description: "Diplayed visibleItems without network")
        var counter = 0

        viewModel.visibleItems = { items in
            if counter == 1 {
                XCTAssertEqual(items, [self.weatherItem])
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_Then_tempTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)
        let expectation = self.expectation(description: "Diplayed tempText with network")

        var counter = 0

        viewModel.tempText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "19 °C")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithoutNetwork_Then_tempTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)
        let expectation = self.expectation(description: "Diplayed tempText without network")

        var counter = 0

        viewModel.tempText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "19 °C")
                expectation.fulfill()
            }
            counter += 1
        }
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_Then_iconTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)
        let expectation = self.expectation(description: "Diplayed iconText with network")

        var counter = 0

        viewModel.iconText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "01d")
                expectation.fulfill()
            }
            counter += 1
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithoutNetwork_Then_iconTextIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)
        let expectation = self.expectation(description: "Diplayed iconText without network")

        var counter = 0

        viewModel.iconText = { text in
            if counter == 1 {
                XCTAssertEqual(text, "01d")
                expectation.fulfill()
            }
            counter += 1
        }

        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_Given_ViewModel_When_ViewDidLoad_Then_isLoadingIsDiplayed() {
        let viewModel = WeekViewModel(repository: repository,
                                         delegate: delegate)
        viewModel.viewDidLoad()

        viewModel.isLoading = { state in
            XCTAssertTrue(state)
        }
    }

    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_isLoadingIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeekViewModel(repository: repository,
                                         delegate: delegate)
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
        let viewModel = WeekViewModel(repository: repository,
                                         delegate: delegate)
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
        let delegate = MockWeatherViewModelDelegate()

        let viewModel = WeekViewModel(repository: repository,
                                         delegate: delegate)

        viewModel.viewDidLoad()
        viewModel.didSelectWeatherDay(at: 0)

        XCTAssertEqual(delegate.weatherItem, self.weatherItem)
    }

    func test_Given_ViewModel_When_noInternetConnection_Then_alert() {
        repository.isSuccess = false
        repository.error = ServiceError.noData
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        XCTAssertEqual(delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_noItems_Then_alert() {
        repository.weatherItems = []
        repository.isSuccess = false
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        XCTAssertEqual(delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_noItemsWithNetwork_Then_alert() {
        repository.weatherItems = []
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        XCTAssertEqual(self.delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_noItemsWithoutNetwork_Then_alert() {
        repository.isFromWeb = false
        repository.weatherItems = []
        let viewModel = WeekViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        XCTAssertEqual(self.delegate.alert, .errorService)
    }
}
