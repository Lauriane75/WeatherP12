//
//  SelectCityViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

protocol SelectCityViewModelDelegate: class {
    func didSelectCity(nameCity: String, country: String)
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

    var parisText: ((String) -> Void)?

    var lyonText: ((String) -> Void)?

    var nantesText: ((String) -> Void)?

    var barcelonaText: ((String) -> Void)?

    var warsawText: ((String) -> Void)?

    var amsterdamText: ((String) -> Void)?

    var brusselsText: ((String) -> Void)?

    var lausanneText: ((String) -> Void)?

    var telAvivText: ((String) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        titleText?("Select an other city")
        parisText?("Paris")
        lyonText?("Lyon")
        nantesText?("Nantes")
        barcelonaText?("Barcelona")
        warsawText?("Warsaw")
        amsterdamText?("Amsterdam")
        brusselsText?("Brussels")
        lausanneText?("Lausanne")
        telAvivText?("Tel Aviv")
    }

    // MARK: - Private Files

    func didSelectCity(nameCity: String, country: String) {
        delegate?.didSelectCity(nameCity: nameCity, country: country)
        repository.getCityWeather(nameCity: nameCity, country: country, callback: { [weak self] weather in
            guard self != nil else { return }
            switch weather {
            case .success(value: let items):
                guard !items.isEmpty else {
                    return
                }
                print("items = \(items)")
            case .error:
                print("error")
            }
        })
    }
}
