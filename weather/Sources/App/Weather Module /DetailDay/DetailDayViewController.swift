//
//  DetailWeatherDayViewController.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class DetailDayViewController: UIViewController {

    // MARK: - Outlet

    @IBOutlet private weak var cityLabel: UILabel!

    @IBOutlet private weak var tempLabel: UILabel!

    @IBOutlet private weak var collectionView: UICollectionView!

    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Properties

    var viewModel: DetailDayViewModel!

    private lazy var collectionDataSource = DetailDayCollectionDataSource()

    private var tableViewDatasource = DetailDayTableViewDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarCustom()

        collectionView.dataSource = collectionDataSource
        tableView.delegate = tableViewDatasource
        tableView.dataSource = tableViewDatasource

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Private Functions

    private func bind(to viewModel: DetailDayViewModel) {

        viewModel.cityText = { [weak self] text in
            self?.cityLabel.text = text.dayPlainTextFormat
        }

        viewModel.tempText = { [weak self] text in
            self?.tempLabel.text = text
        }

        viewModel.descriptionText = { [weak self] text in
            self?.descriptionLabel.text = text
        }

        viewModel.visibleItems = { [weak self] items in
            guard let self = self else { return }
            self.collectionDataSource.update(with: items)
            self.tableViewDatasource.update(with: items)
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }

    // MARK: - Private Files

    fileprivate func navigationBarCustom() {
        guard let bar = navigationController?.navigationBar else { return }
        bar.tintColor = .white
    }
}
