//
//  Extension.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

extension String {
    var dayPlainTextFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let convertedDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: convertedDate)
    }

    var hourFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let convertedDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: convertedDate)
    }

    var dayFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let convertedDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: convertedDate)
    }
}

extension StringProtocol {
    var firstCapitalized: String {
        return String(prefix(1)).capitalized + dropFirst()
    }
}
