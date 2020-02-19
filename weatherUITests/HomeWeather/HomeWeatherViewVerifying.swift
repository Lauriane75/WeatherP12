//
//  HomeWeatherViewVerifying.swift
//  weatherUITests
//
//  Created by Lauriane Haydari on 17/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import XCTest

protocol HomeWeatherViewVerifying {

    func homeWeatherViewWaitForExistence()
    func homeWeatherViewExists() -> Bool

    // MARK: - Properties

    var parisLabel: XCUIElement { get }
    var nowLabel: XCUIElement { get }
    var tempLabel: XCUIElement { get }
    var icon: XCUIElement { get }
    var selectedItem: XCUIElement { get }
}

extension HomeWeatherViewVerifying {

    func homeWeatherViewWaitForExistence() {
        _ = parisLabel.waitForExistence(timeout: 1)
        _ = nowLabel.waitForExistence(timeout: 1)
        _ = tempLabel.waitForExistence(timeout: 1)
        _ = icon.waitForExistence(timeout: 1)
    }

    func homeWeatherViewExists() -> Bool {
        return parisLabel.exists
            && nowLabel.exists
            && tempLabel.exists
            && icon.exists
    }

    // MARK: - Properties

    var parisLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.parisText]
    }
    var nowLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.nowText]
    }
    var tempLabel: XCUIElement {
        return XCUIApplication().staticTexts[Accessibility.HomeWeatherView.tempText]
    }
    var icon: XCUIElement {
        return XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
    }
   var selectedItem: XCUIElement {
        return   XCUIApplication().tables.cells.containing(.staticText, identifier:Accessibility.HomeWeatherView.selectedDayText).children(matching: .staticText).matching(identifier: Accessibility.HomeWeatherView.selectedTempText).element(boundBy: 2)
    }
}


