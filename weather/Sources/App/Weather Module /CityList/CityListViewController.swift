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

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var theWeatherChanelButton: UIButton!

    // MARK: - Properties

    var viewModel: CityListViewModel!

    private var source = CityListDataSource()

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
        viewModel.visibleWeatherItems = { [weak self] weatherItems in
            DispatchQueue.main.async {
                self?.source.update(with: weatherItems)
                self?.tableView.reloadData()
            }
        }

        viewModel.isLoading = { [weak self] loadingState in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loadingState {
                case true:
                    self.tableView.isHidden = true
                    self.label.isHidden = false
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                case false:
                    self.tableView.isHidden = false
                    self.label.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }

        viewModel.labelText = { [weak self] text in
            self?.label.text = text
        }
        viewModel.labelState = { [weak self] state in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch state {
                case true:
                    self.label.isHidden = false
                case false:
                    self.label.isHidden = true
                }
            }
        }
    }

    private func bind(to source: CityListDataSource) {
        source.selectedCity = viewModel.didSelectCity
        source.selectedCityToDelete = viewModel.didPressDeleteCity
    }

    // MARK: - View actions

    @IBAction func didPressWeatherChanelButton(_ sender: Any) {
        let url = viewModel.returnUrl()
        UIApplication.shared.open(url)
    }

    // MARK: - Private Files

    fileprivate func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                 NSAttributedString.Key.font: UIFont(name: "kailasa", size: 20)]
        bar.titleTextAttributes = textAttributes as [NSAttributedString.Key: Any]
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
        bar.tintColor = .white
        bar.clipsToBounds = false
        bar.shadowImage = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0).image(CGSize(width: self.view.frame.width, height: 1))
        viewModel.navBarTitle = { text in
            self.navigationItem.title = text
        }
    }
}
