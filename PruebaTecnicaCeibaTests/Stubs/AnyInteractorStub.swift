//
//  AnyInteractorStub.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import Combine
@testable import PruebaTecnicaCeiba

class AnyInteractorStub<Params, Response>: AnyInteractor<Params, Response> {
    enum InteractorStubCase {
        case success ((Params) -> Response)
        case failure ((Params) -> Error)
    }
    
    var responseHandler: InteractorStubCase
    
    override init() {
        responseHandler = .failure { _ in
            CostumErrors.ApiRequest.pageNotFound
        }
    }
    
    override func execute(params: Params) -> AnyPublisher<Response, Error> {
        switch responseHandler {
        case .success(let handler):
            return CurrentValueSubject<Response, Error>(handler(params))
                .eraseToAnyPublisher()
        case .failure(let errorHandler):
            return Fail<Response, Error>(error: errorHandler(params))
                .eraseToAnyPublisher()
        }
    }
}
