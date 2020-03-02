//
//  CityListViewController.swift
//  weather
//
//  Created by Lauriane Haydari on 02/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {

    // MARK: - Outlet

    // MARK: - Properties

    var viewModel: CityListViewModel!

//    private var source = CityListDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

//      navigationBarCustom()

        bind(to: viewModel)
//        bind(to: source)

        viewModel.viewDidLoad()
    }

    // MARK: - Private Functions

     private func bind(to viewModel: CityListViewModel) {

    }

//    private func bind(to source: CityListDataSource) {
//         source.selectedCity = viewModel.didSelectCity
//     }

}
