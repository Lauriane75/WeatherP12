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
        let cityInfo = CityItem(nameCity: nameCity, country: country)
        repository.getCityWeather(nameCity: nameCity, country: country, callback: { [weak self] weather in
            guard let self = self else { return }
            switch weather {
            case .success(value: let dataOrigin):
                switch dataOrigin {
                case .web(let items):
                    guard !items.isEmpty else {
                        self.delegate?.displayAlert(for: .errorService)
                        return
                    }
                    self.repository.saveCityItem(city: cityInfo)
                case .noService(let items):
                    self.delegate?.displayAlert(for: .errorService)
                    print("items = \(items)")
                }
            case .error:
                self.delegate?.displayAlert(for: .errorService)
            }
        })
    }
}
