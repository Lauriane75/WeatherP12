//
//  SelectCityViewModelTests.swift
//  weatherTests
//
//  Created by Lauriane Haydari on 17/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest
@ testable import weather

// MARK: - Mock

class MocSelectCityViewModelDelegate: SelectCityViewModelDelegate {

    var alert: AlertType?
    func displayAlert(for type: AlertType) {
        self.alert = type
    }
}

// MARK: - Tests

class SelectCityViewModelTests: XCTestCase {

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

    let repository = MockWeatherRepository()
    let delegate = MocSelectCityViewModelDelegate()

    func test_Given_ViewModel_When_ViewdidLoad_Then_titleTextIsDisplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.titleText = { text in
            XCTAssertEqual(text, "Select an other city")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewdidLoad_Then_cityTextIsDisplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.cityText = { text in
            XCTAssertEqual(text, "Enter a city")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewdidLoad_Then_cityPlaceHoldertIsDisplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.cityPlaceHolder = { text in
            XCTAssertEqual(text, "Paris")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewdidLoad_Then_countryTextIsDisplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.countryText = { text in
            XCTAssertEqual(text, "Enter it's country")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewdidLoad_Then_countryPlaceHolderIsDisplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.countryPlaceHolder = { text in
            XCTAssertEqual(text, "France")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewdidLoad_Then_addTextIsDisplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.addButtonText = { text in
            XCTAssertEqual(text, "Add this city to the list")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_didPressAddCity_Then_AddButtonIsDiplayed() {

        repository.weatherItems = [self.weatherItem]

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        viewModel.addButtonText = { text in
            XCTAssertEqual(text, "You've just added Paris")
        }

        viewModel.didPressAddCity(nameCity: "paris", country: "france")
    }

    func test_Given_ViewModel_When_didPressAddCityWithoutNetwork_Then_Alert() {

        repository.weatherItems = [self.weatherItem]
        repository.isFromWeb = false

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        viewModel.didPressAddCity(nameCity: "paris", country: "france")

        XCTAssertEqual(delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_didPressAddCityEmpty_Then_Alert() {

        repository.weatherItems = []
        repository.isFromWeb = false

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        viewModel.didPressAddCity(nameCity: "paris", country: "france")

        XCTAssertEqual(delegate.alert, .errorService)
    }

    func test_Given_ViewModel_When_addbuttonNormalState_Then_AddButtonIsDiplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.viewDidLoad()

        viewModel.addbuttonNormalState()

        viewModel.addButtonText = { text in
            XCTAssertEqual(text, "Add this city to the list")
        }
    }
}
