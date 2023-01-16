//
//  CoreDataInteractorStub.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import Combine
@testable import PruebaTecnicaCeiba

final class CoreDataInteractorStub: CoreDataRepositoryType {
    enum InteractorStubCase<T> {
        case success(() -> T)
        case failure(() -> Error)
    }
    
    private var usersObject:[UserModel] = []
    var responseHandler: InteractorStubCase<Any>
    
    init(users: [UserModel] ) {
        usersObject = users
        responseHandler = .failure({
            CostumErrors.ApiRequest.pageNotFound
        })
    }
    
    func save(with data: PruebaTecnicaCeiba.UserModel) -> AnyPublisher<Bool, Error> {
        var publisher = CurrentValueSubject<Bool, Error>(true)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<Bool, Error>(true)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    func retriveData() -> AnyPublisher<[PruebaTecnicaCeiba.UserModel], Error> {
        var publisher = CurrentValueSubject<[UserModel], Error>(usersObject)
        switch responseHandler {
        case .success(_):
            publisher = CurrentValueSubject<[UserModel], Error>(usersObject)
        case .failure(let errorHandler):
            publisher.send(completion: .failure(errorHandler()))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
