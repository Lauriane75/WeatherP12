//
//  CityListViewVerifying.swift
//  weatherUITests
//
//  Created by Lauriane Haydari on 06/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol CityListViewVerifying {

    func cityListViewWaitForExistence()
    func cityListViewExists() -> Bool

    // MARK: - Properties

    var cityLabel: XCUIElement { get }
    var tempLabel: XCUIElement { get }
    var selectedItem: XCUIElement { get }
    var itemPlus: XCUIElement { get }

}

extension CityListViewVerifying {

    func cityListViewWaitForExistence() {
        _ = cityLabel.waitForExistence(timeout: 1)
        _ = tempLabel.waitForExistence(timeout: 1)
    }

    func cityListViewExists() -> Bool {
        return cityLabel.exists
            && tempLabel.exists
    }

    // MARK: - Properties

    var cityLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.parisText]
    }

    var tempLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.tempText]
    }

    var selectedItem: XCUIElement {
        return   XCUIApplication()
            .tables.cells.containing(.staticText,
                identifier: Accessibility.HomeWeatherView.selectedDayText)
            .children(matching: .staticText).matching(
                identifier: Accessibility.HomeWeatherView.selectedTempText).element(boundBy: 2)
    }

    var itemPlus: XCUIElement {
        return XCUIApplication().tabBars.buttons["plus.circle"]
    }

}
