//
//  Screens.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class Screens {

    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))

    private let context: Context
    private let stack: CoreDataStack

    init(context: Context, stack: CoreDataStack) {
        self.context = context
        self.stack = stack
    }
}

// MARK: - Main

extension Screens {
    func createMainViewController(delegate: WeatherViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier:
            "WeatherViewController") as! WeatherViewController
        let repository = WeatherRepository(client: context.client,
                                           stack: stack)
        let viewModel = WeatherViewModel(repository: repository,
                                         delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

//extension Screens {
//    func creatWeatherCityViewController(delegate: WeatherViewModelDelegate?, cityName: String, country: String) -> UIViewController {
//        let viewController = storyboard.instantiateViewController(withIdentifier:
//            "WeatherViewController") as! WeatherViewController
//        let repository = WeatherRepository(client: context.client,
//                                           stack: stack)
//        let viewModel = WeatherViewModel(repository: repository,
//                                         delegate: delegate)
//        viewController.viewModel = viewModel
//        return viewController
//    }
//}

// MARK: - Select City

extension Screens {
    func createSelectCityViewController(delegate: SelectCityViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier:
            "SelectCityViewController") as! SelectCityViewController
        let repository = WeatherRepository(client: context.client,
        stack: stack)
        let viewModel = SelectCityViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Detail

extension Screens {
    func createWeatherDetailViewController(selectedWeatherItem: WeatherItem,
                                           delegate: DetailWeatherDayViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier:
            "DetailWeatherDayViewController") as! DetailWeatherDayViewController
        let repository = WeatherRepository(client: context.client, stack: stack)
        let viewModel = DetailWeatherDayViewModel(repository: repository,
                                                  delegate: delegate,
                                                  selectedWeatherItem: selectedWeatherItem)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Alert

extension Screens {
    func createAlertView(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertViewController = UIAlertController(title: alert.title,
                                                    message: alert.message,
                                                    preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertViewController.addAction(action)
        return alertViewController
    }
}
