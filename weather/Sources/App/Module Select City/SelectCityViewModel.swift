//
//  SelectCityViewModel.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

final class SelectCityViewModel {
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
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
}
