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
        case sectionNotFound
        case malformedURL
        case serverError
        case notInternetConnection
    }
    
    enum StatusCodes: Int {
        case successStatusCode = 200
        case redirectionStatusCode = 300
        case badRequestStatusCode = 400
        case notAuthenticatedStatusCode = 401
        case unauthorizedStatusCode = 403
        case pageNotFound = 404
        case internalServerErrorStatusCode = 500
        case notInternetConnection = -1020
        
        init(from rawValue: Int) {
            self = StatusCodes(rawValue: rawValue) ?? .internalServerErrorStatusCode
        }
    }
}
