//
//  CostumErrors.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation

public enum CostumErrors: Error, Equatable {
   public enum ApiRequest: Error {
        case serviceError(description: String)
        case errorCoreData
        case pageNotFound
        case serverError
        case notInternetConnection
    }
    
    enum StatusCodes: Int {
        case successStatusCode = 200
        case pageNotFound = 404
        case internalServerErrorStatusCode = 500
        case notInternetConnection = -1009
        
        init(from rawValue: Int) {
            self = StatusCodes(rawValue: rawValue) ?? .internalServerErrorStatusCode
        }
    }
}

extension CostumErrors.ApiRequest {
    init?(statusCode: CostumErrors.StatusCodes, description: String? = nil, data: Data? = nil) {
        switch statusCode {
        case .pageNotFound:
            self = .pageNotFound
        case .notInternetConnection:
            self = .notInternetConnection
        default:
             self = .serverError
        }
    }
}
