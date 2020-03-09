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
    case cityExists
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
        case .cityExists:
            self = Alert(title: "Error", message: "You've already added this city")
        }
    }
}
