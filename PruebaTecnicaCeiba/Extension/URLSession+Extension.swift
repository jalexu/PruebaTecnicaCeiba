//
//  URLSession+Extension.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation

public extension URLSession {
    static func configuration(
        timeOut: Int = 60,
        requestCahePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData
    ) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = requestCahePolicy
        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
        return configuration
    }
}
