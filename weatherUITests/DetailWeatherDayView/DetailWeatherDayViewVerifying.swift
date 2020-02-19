//
//  DetailWeatherDayViewVerifying.swift
//  weatherUITests
//
//  Created by Lauriane Haydari on 17/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol DetailWeatherDayViewVerifying {
    
    func showDetailWeatherDayView()
    
    func detailWeatherDayViewWaitForExistence()
    func detailWeatherDayViewExists() -> Bool
    
    // MARK: - Properties
    
    var dayLabel: XCUIElement { get }
    var tempLabel: XCUIElement { get }
    var descriptionLabel: XCUIElement { get }
}

extension DetailWeatherDayViewVerifying {
    
    func showDetailWeatherDayView() {
        let homeWeatherViewUITest = HomeWeatherViewUITests()
        homeWeatherViewUITest.test_go_to_DetailWeatherDayView()
    }
    
    func detailWeatherDayViewWaitForExistence() {
        _ = dayLabel.waitForExistence(timeout: 1)
        _ = tempLabel.waitForExistence(timeout: 1)
        _ = descriptionLabel.waitForExistence(timeout: 1)
    }
    
    func detailWeatherDayViewExists() -> Bool {
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
