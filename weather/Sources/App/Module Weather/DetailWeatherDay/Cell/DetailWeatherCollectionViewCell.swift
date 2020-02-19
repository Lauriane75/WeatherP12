//
//  DetailWeatherCollectionViewCell.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

final class DetailWeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Configure
    
    func configure(with visibleWeather: WeatherItem) {
        timeLabel.text = visibleWeather.time.hourFormat
        iconImageView.image = UIImage(named: visibleWeather.iconID)
        tempLabel.text = visibleWeather.temperature
    }
}
