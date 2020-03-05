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

//    func test_Given_DetailViewModel_When_ViewdidLoad_Then_IsDisplayed() {
//
//        let repository = MockWeatherRepository()//
//        viewModel.titleText = { text in
//            XCTAssertEqual(text, "Select an other city")
//        }
//        viewModel.viewDidLoad()
//    }
}
