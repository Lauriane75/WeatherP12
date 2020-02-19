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

class MockWeatherViewModelDelegate: WeatherViewModelDelegate {
    
    var alert: AlertType? = nil
    
    var weatherItem: WeatherItem? = nil
    
    func didSelect(item: WeatherItem) {
        self.weatherItem = item
    }
    
    func displayWeatherAlert(for type: AlertType) {
        self.alert = type
    }
}

class MockWeatherRepository: WeatherRepositoryType {
    var weatherItems: [WeatherItem]?
    var isSuccess = true
    var isFromWeb = true
    var weatherOrigin: WeatherOrigin!
    var error: Error!
    
    func saveWeatherItems(items: WeatherItem) {
        
    }
    
    func getWeatherItems(callback: @escaping ([WeatherItem]) -> Void) {
        guard weatherItems != nil else { return }
        callback(weatherItems!)
    }
    
    func deleteInDataBase(timeWeather: String) {
        
    }
    
    func getWeather(callback: @escaping (Result<WeatherOrigin>) -> Void) {
        if let weatherItems = weatherItems {
            callback(.success(value: isFromWeb ? .web(weatherItems) : .database(weatherItems)))
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
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        
        viewModel.cityText = { text in
            XCTAssertEqual(text, "Paris")
        }
        
        viewModel.viewDidLoad()
    }
    
    func test_Given_ViewModel_When_ViewDidLoad_Then_nowTextIsDiplayed() {
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        
        viewModel.nowText = { text in
            XCTAssertEqual(text, "Now")
        }
        
        viewModel.viewDidLoad()
    }
    
    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_Then_visibleItemsAreDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeatherViewModel(repository: repository,
                                         delegate: delegate)
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
        let viewModel = WeatherViewModel(repository: repository,
                                         delegate: delegate)
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
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
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
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
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
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
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
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        let expectation = self.expectation(description: "Diplayed iconText without network")
        
        viewModel.iconText = { text in
            XCTAssertEqual(text, "01d")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_Given_ViewModel_When_ViewDidLoad_Then_isLoadingIsDiplayed() {
        let viewModel = WeatherViewModel(repository: repository,
                                         delegate: delegate)
        viewModel.viewDidLoad()
        
        viewModel.isLoading = { state in
            XCTAssertTrue(state)
        }
    }
    
    func test_Given_ViewModel_When_ViewDidLoad_WhithNetwork_isLoadingIsDiplayed() {
        repository.weatherItems = [self.weatherItem]
        let viewModel = WeatherViewModel(repository: repository,
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
        let viewModel = WeatherViewModel(repository: repository,
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

        let viewModel = WeatherViewModel(repository: repository,
                                         delegate: delegate)

        viewModel.viewDidLoad()
        viewModel.didSelectWeatherDay(at: 0)
        
        XCTAssertEqual(delegate.weatherItem, self.weatherItem)
    }
    
    func test_Given_ViewModel_When_noInternetConnection_Then_alert() {
        repository.isSuccess = false
        repository.error = ServiceError.noData
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(delegate.alert, .errorService)
    }
    
    func test_Given_ViewModel_When_noItems_Then_alert() {
        repository.weatherItems = []
        repository.isSuccess = false
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(delegate.alert, .errorService)
    }
    
    func test_Given_ViewModel_When_noItemsWithNetwork_Then_alert() {
        repository.weatherItems = []
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(self.delegate.alert, .errorService)
    }
    
    func test_Given_ViewModel_When_noItemsWithoutNetwork_Then_alert() {
        repository.isFromWeb = false
        repository.weatherItems = []
        let exp = expectation(description: "")
        let viewModel = WeatherViewModel(repository: repository, delegate: delegate)
        
        viewModel.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            XCTAssertEqual(self.delegate.alert, .errorService)
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 5.0)
    }
}
