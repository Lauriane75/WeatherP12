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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var viewModel: CityListViewModel!

    private var source = CityDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarCustom()

        tableView.delegate = source
        tableView.dataSource = source

        bind(to: viewModel)
        bind(to: source)

        viewModel.viewDidLoad()
    }

    // MARK: - Private Functions

    private func bind(to viewModel: CityListViewModel) {
        viewModel.visibleItems = { [weak self] items in
            DispatchQueue.main.async {
                self?.source.update(with: items)
                self?.tableView.reloadData()
            }
        }
        viewModel.isLoading = { [weak self] loadingState in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loadingState {
                case true:
                    //                    self.tableView.isHidden = true
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                case false:
                    //                    self.tableView.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }

    private func bind(to source: CityDataSource) {
        source.selectedCity = viewModel.didSelectCity
    }

    func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        bar.alpha = 0.0
    }
}
