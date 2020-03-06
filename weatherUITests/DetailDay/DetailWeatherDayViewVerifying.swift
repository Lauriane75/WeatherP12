//
//  DetailWeatherDayViewVerifying.swift
//  weatherUITests
//
//  Created by Lauriane Haydari on 17/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol DetailWeatherDayViewVerifying {

    func showDetailDayView()

    func detailDayViewWaitForExistence()
    func detailDayViewExists() -> Bool

    // MARK: - Properties

    var dayLabel: XCUIElement { get }
    var tempLabel: XCUIElement { get }
    var descriptionLabel: XCUIElement { get }
}

extension DetailWeatherDayViewVerifying {

    func showDetailDayView() {
        let weekViewUITest = WeekViewUITests()
        weekViewUITest.test_go_to_DetailWeatherDayView()
    }

    func detailDayViewWaitForExistence() {
        _ = dayLabel.waitForExistence(timeout: 1)
        _ = tempLabel.waitForExistence(timeout: 1)
        _ = descriptionLabel.waitForExistence(timeout: 1)
    }

    func detailDayViewExists() -> Bool {
        return dayLabel.exists
            && tempLabel.exists
            && descriptionLabel.exists
    }

    // MARK: - Properties

    var dayLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.selectedDayText]
    }
    var tempLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.selectedTempText]
    }
    var descriptionLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.DetailWeatherDayView.descriptionText]
    }
}
