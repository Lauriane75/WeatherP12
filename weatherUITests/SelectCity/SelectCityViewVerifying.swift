//
//  SelectCityViewVerifying.swift
//  weatherUITests
//
//  Created by Lauriane Haydari on 06/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol SelectCityViewVerifying {

    func showSelectCityView()

//    func selectCityViewWaitForExistence()
//    func selectCityViewExists() -> Bool

    // MARK: - Properties

//    var dayLabel: XCUIElement { get }
//    var tempLabel: XCUIElement { get }
//    var descriptionLabel: XCUIElement { get }
}

extension SelectCityViewVerifying {

    func showSelectCityView() {
        let cityListViewUITest = CityListViewUITests()
        cityListViewUITest.test_go_to_SelectCityView()
    }

//    func selectCityViewWaitForExistence() {
//        _ = dayLabel.waitForExistence(timeout: 1)
//        _ = tempLabel.waitForExistence(timeout: 1)
//        _ = descriptionLabel.waitForExistence(timeout: 1)
//    }

//    func selectCityViewExists() -> Bool {
//        return dayLabel.exists
//            && tempLabel.exists
//            && descriptionLabel.exists
//    }

    // MARK: - Properties

//    var dayLabel: XCUIElement {
//        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.selectedDayText]
//    }
//    var tempLabel: XCUIElement {
//        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.selectedTempText]
//    }
//    var descriptionLabel: XCUIElement {
//        return XCUIApplication().staticTexts[Accessibility.DetailWeatherDayView.descriptionText]
//    }
}
