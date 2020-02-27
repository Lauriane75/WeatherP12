//
//  MainCoordinator.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case weather = 0
    case selectCity
}

protocol TabBarSourceType {
    var items: [UINavigationController] { get set }
}

extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exists")
            }
            return items[item.rawValue]
        }
    }
}

private class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]

    init() {
        self[.weather].tabBarItem.image = UIImage(systemName: "sun.max")
        self[.selectCity].tabBarItem.image = UIImage(systemName: "plus.circle")
    }
}

final class MainCoordinator: NSObject, UITabBarControllerDelegate {

    // MARK: - Properties

    private let presenter: UIWindow

    private let tabBarController: UITabBarController

    private let screens: Screens

    private let context: Context

    private let stack: CoreDataStack

    private var tabBarSource: TabBarSourceType = TabBarSource()

    private var weatherCoordinator: WeatherCoordinator?

    private var selectCityCoordinator: SelectCityCoordinator?

    // MARK: - Init

    init(presenter: UIWindow, context: Context, stack: CoreDataStack) {
        self.presenter = presenter
        self.context = context
        self.stack = stack
        self.screens = Screens(context: context, stack: stack)

        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = tabBarSource.items
        tabBarController.selectedViewController = tabBarSource[.weather]

        super.init()

        tabBarController.delegate = self
    }

    func start() {
        presenter.rootViewController = tabBarController
        showMainView()
    }

    private func showMainView() {
        weatherCoordinator = WeatherCoordinator(presenter: tabBarSource[.weather], screens: screens)
        weatherCoordinator?.start()
    }

    private func showSelectCityView() {
        selectCityCoordinator = SelectCityCoordinator(presenter: tabBarSource[.selectCity], screens: screens)
        selectCityCoordinator?.start()
    }
}

extension MainCoordinator {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < tabBarSource.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Selected ViewController Index Out Of range")
        }

        switch item {
        case .weather:
            showMainView()
        case .selectCity:
            showSelectCityView()
        }
    }
}
