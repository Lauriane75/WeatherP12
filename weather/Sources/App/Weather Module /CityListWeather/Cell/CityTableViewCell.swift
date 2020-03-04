//
//  CityTableViewCell.swift
//  weather
//
//  Created by Lauriane Haydari on 02/03/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class CityTableViewCell: UITableViewCell {

    // MARK: - Outlet

    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var tempLabel: UILabel!

    // MARK: - Configure

    func configure(with visibleWeather: WeatherItem) {
        cityLabel.text = visibleWeather.nameCity
        tempLabel.text = visibleWeather.temperature
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.text = nil
        tempLabel.text = nil
    }
}
