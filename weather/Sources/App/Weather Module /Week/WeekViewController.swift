//
//  WeatherViewController.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var cityLabel: UILabel!

    @IBOutlet private weak var tempLabel: UILabel!

    @IBOutlet private weak var nowLabel: UILabel!

    @IBOutlet private weak var iconImageView: UIImageView!

    // MARK: - Properties

    var viewModel: WeekViewModel!

    private var source = WeekDataSource()

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

    private func bind(to viewModel: WeekViewModel) {
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
                    self.tableView.isHidden = true
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                case false:
                    self.tableView.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }

        viewModel.tempText = { [weak self] text in
            DispatchQueue.main.async {
                self?.tempLabel.text = text
            }
        }

        viewModel.iconText = { [weak self] text in
            DispatchQueue.main.async {
                self?.iconImageView.image = UIImage(named: text)
            }
        }

        viewModel.cityText = { [weak self] text in
            DispatchQueue.main.async {
                self?.cityLabel.text = text
            }
        }

        viewModel.nowText = { [weak self] text in
            self?.nowLabel.text = text
        }
    }

    private func bind(to source: WeekDataSource) {
        source.selectedWeatherDay = viewModel.didSelectWeatherDay
    }

    // MARK: - Private Files

    func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        bar.tintColor = .white
    }
}
