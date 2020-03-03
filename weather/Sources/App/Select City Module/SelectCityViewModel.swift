//
//  SelectCityViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol SelectCityViewModelDelegate: class {
    func didPressAddCity(nameCity: String, country: String)
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

    var addText: ((String) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        titleText?("Select an other city")
        cityText?("Enter the name of the city")
        cityPlaceHolder?("Paris")
        countryText?("Enter the first two letters of the country")
        countryPlaceHolder?("fr")
        addText?("Add this city to the list")
    }

    // MARK: - Private Files

    func didPressAddCity(nameCity: String, country: String) {
        delegate?.didPressAddCity(nameCity: nameCity, country: country)
    }
}

struct CityInfo: Equatable {
    let nameCity: String
    let country: String
}
