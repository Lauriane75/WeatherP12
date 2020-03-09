//
//  Alert.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

enum AlertType {
    case errorService
    case wrongCityInfo
}

struct Alert {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .errorService:
            self = Alert(title: "Error", message: "No internet connection")
        case .wrongCityInfo:
            self = Alert(title: "Error", message: "Make sure you right the city and the two first letters of the country correctly")
        }
    }
}
