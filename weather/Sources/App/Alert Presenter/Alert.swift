//
//  Alert.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case noData
}

enum AlertType {
    case errorService
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
        }
    }
}
