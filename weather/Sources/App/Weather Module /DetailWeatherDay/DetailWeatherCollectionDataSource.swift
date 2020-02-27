//
//  DetailWeatherDataSource.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import UIKit

class DetailWeatherCollectionDataSource: NSObject, UICollectionViewDataSource {

    // MARK: Private properties

    private var items: [WeatherItem] = []

    // MARK: Public function

    func update(with items: [WeatherItem]) {
        self.items = items
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard items.count > indexPath.item else {
            return UICollectionViewCell() // Should be monitored
        }
        let visibleWeather = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailWeatherCollectionViewCell",
                                                      for: indexPath)
            as! DetailWeatherCollectionViewCell
        cell.configure(with: visibleWeather)
        return cell
    }
}
