//
//  HomeWeatherViewUITests.swift
//  weatherUITests
//
//  Created by Lauriane Haydari on 17/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest

// Make sure the accessibility file is updated!

class HomeWeatherViewUITests: UITestCase, RootViewStarting, HomeWeatherViewVerifying {

    func test_Verifying_HomeWeatherView() {
        // Wait
        homeWeatherViewWaitForExistence()
        // Check view
        XCTAssertTrue(homeWeatherViewExists())
    }

    func test_go_to_DetailWeatherDayView() {
        _ = selectedItem.waitForExistence(timeout: 1)
        XCTAssertTrue(selectedItem.exists)
        selectedItem.tap()
    }
}
