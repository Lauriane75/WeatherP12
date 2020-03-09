//
//  HTTPEngine.swift
//  weather
//
//  Created by Lauriane Haydari on 12/02/2020.
//  Copyright © 2020 Lauriane Haydari. All rights reserved.
//

import Foundation

typealias HTTPCompletionHander = (Data?, HTTPURLResponse?, Error?) -> Void

enum URLSessionEngineError: Error {
    case invalidURLResponseType
}

final class HTTPEngine {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Inputs

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    func send(request: URLRequest,
              cancelledBy token: RequestCancelationToken,
              callback: @escaping HTTPCompletionHander) {
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if urlResponse != nil {
                guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                    callback(data, nil, URLSessionEngineError.invalidURLResponseType)
                    return
                }
                callback(data, httpURLResponse, error)
            } else {
                callback(data, nil, error)
            }
        }
        task.resume()
        token.willDealocate = {
            task.cancel()
        }
    }

    deinit {
        session.invalidateAndCancel()
    }
}
