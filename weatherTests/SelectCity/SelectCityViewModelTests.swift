//
//  SelectCityViewModelTests.swift
//  weatherTests
//
//  Created by Lauriane Haydari on 17/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest
@ testable import weather

// MARK: - Tests

class SelectCityViewModelTests: XCTestCase {

    let weatherItem = WeatherItem(time: "2020-02-13 12:00:00",
                                  temperature: "19 °C",
                                  iconID: "01d",
                                  temperatureMax: "20 °C",
                                  temperatureMin: "15 °C",
                                  pressure: "1002 hPa",
                                  humidity: "50 %",
                                  feelsLike: "18 °C",
                                  description: "Sunny")

    func test_Given_DetailViewModel_When_ViewdidLoad_Then_IsDisplayed() {
        let viewModel = SelectCityViewModel()

        viewModel.titleText = { text in
            XCTAssertEqual(text, "Select an other city")
        }
        viewModel.parisText = { text in
            XCTAssertEqual(text, "Paris")
        }
        viewModel.lyonText = { text in
            XCTAssertEqual(text, "Lyon")
        }
        viewModel.nantesText = { text in
            XCTAssertEqual(text, "Nantes")
        }
        viewModel.barcelonaText = { text in
            XCTAssertEqual(text, "Barcelona")
        }
        viewModel.warsawText = { text in
            XCTAssertEqual(text, "Warsaw")
        }
        viewModel.brusselsText = { text in
            XCTAssertEqual(text, "Brussels")
        }
        viewModel.lausanneText = { text in
            XCTAssertEqual(text, "Lausanne")
        }
        viewModel.telAvivText = { text in
            XCTAssertEqual(text, "Tel Aviv")
        }

        viewModel.viewDidLoad()
    }
}
