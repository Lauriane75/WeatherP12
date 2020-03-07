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

}

// MARK: - Tests

class SelectCityViewModelTests: XCTestCase {

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
            XCTAssertEqual(text, "Enter the name of the city")
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
            XCTAssertEqual(text, "Enter the first two letters of the country")
        }
        viewModel.viewDidLoad()
    }

    func test_Given_ViewModel_When_ViewdidLoad_Then_countryPlaceHolderIsDisplayed() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.countryPlaceHolder = { text in
            XCTAssertEqual(text, "fr")
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

    func test_Given_ViewModel_When_didPressAddCity_Then_() {

        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)

        viewModel.didPressAddCity(nameCity: "paris", country: "fr")

        viewModel.viewDidLoad()
    }

}
