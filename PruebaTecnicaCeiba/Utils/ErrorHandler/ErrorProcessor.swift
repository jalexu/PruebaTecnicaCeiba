//
//  ErrorProcessor.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

protocol ErrorProcessorType {
    var errorHandler: ErrorHandlerType? { get set }
    func handleExceptionError(error: Error)
}

extension ErrorProcessorType {
    func handleExceptionError(error: Error) {
        switch error {
        case let error as CostumErrors.ApiRequest:
            sendServiceError(error: error)
        default:
            errorHandler?.showError(error: error)
        }
    }
    
    private func sendServiceError(error: CostumErrors.ApiRequest) {
        switch error {
        case .notInternetConnection:
            errorHandler?.showLostConnectionError()
        default:
            errorHandler?.showError(error: error)
        }
    }
}

