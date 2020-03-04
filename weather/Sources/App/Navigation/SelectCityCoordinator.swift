//
//  SelectCityCoordinator.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class SelectCityCoordinator {

    // MARK: - Properties

    private let presenter: UINavigationController

    private let screens: Screens

    // MARK: - Initializer

    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }

    // MARK: - Coodinator

    func start() {
        showHome()
    }

    private func showHome() {
        let viewController = screens.createSelectCityViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }

    private func showAlert(for type: AlertType) {
        let alert = screens.createAlertView(for: type)
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension SelectCityCoordinator: SelectCityViewModelDelegate {
}
