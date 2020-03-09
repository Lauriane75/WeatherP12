//
//  SelectCityViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol SelectCityViewModelDelegate: class {
    func displayAlert(for type: AlertType)
}

final class SelectCityViewModel {

    // MARK: - Properties

    private let repository: WeatherRepositoryType

    private weak var delegate: SelectCityViewModelDelegate?

    // MARK: - Initializer

    init(repository: WeatherRepositoryType, delegate: SelectCityViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var titleText: ((String) -> Void)?

    var cityText: ((String) -> Void)?

    var cityPlaceHolder: ((String) -> Void)?

    var countryText: ((String) -> Void)?

    var countryPlaceHolder: ((String) -> Void)?

    var addButtonText: ((String) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        titleText?("Select an other city")
        cityText?("Enter a city")
        cityPlaceHolder?("Paris")
        countryText?("Enter it's country")
        countryPlaceHolder?("France")
        addButtonText?("Add this city to the list")
    }

    func addbuttonNormalState() {
        addButtonText?("Add this city to the list")
    }

    // MARK: - Private Files

    func didPressAddCity(nameCity: String, country: String) {
        checkCity(cityName: nameCity, country: country)
        addButtonText?("Error wrong speeling")
        repository.getCityWeather(nameCity: nameCity, country: country, callback: { [weak self] weather in
            guard let self = self else { return }
            switch weather {
            case .success(value: _):
                self.addButtonText?("You've just added \(nameCity.firstCapitalized)")
                self.repository.saveCityItem(city: CityItem(nameCity: nameCity,
                                                            country: country))
            case .error:
                self.delegate?.displayAlert(for: .errorService)
            }
        })
    }

    private func checkCity(cityName: String, country: String) {
        repository.getCityItems { (cityItems) in
            cityItems.forEach { item in
                guard item.nameCity != cityName && item.country != country else {
                    self.delegate?.displayAlert(for: .cityExists)
                    return }
            }
        }
    }
}
