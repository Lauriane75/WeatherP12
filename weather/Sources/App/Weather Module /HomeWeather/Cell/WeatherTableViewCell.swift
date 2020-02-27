//
//  WeatherTableViewCell.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempMinLabel: UILabel!
    @IBOutlet private weak var tempMaxLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!

    // MARK: - Configure

    func configure(with visibleWeather: WeatherItem) {
        dayLabel.text = visibleWeather.time.dayPlainTextFormat
        iconImageView.image = UIImage(named: visibleWeather.iconID)
        tempMinLabel.text = String(visibleWeather.temperatureMin)
        tempMaxLabel.text = String(visibleWeather.temperatureMax)
        tempLabel.text = String(visibleWeather.temperature)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        iconImageView.image = nil
        tempMinLabel.text = nil
        tempMaxLabel.text = nil
        tempLabel.text = nil
    }
}
