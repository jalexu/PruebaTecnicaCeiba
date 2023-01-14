//
//  CoreDataInteractor.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Combine

public protocol CoreDataInteractorType {
    func save(with data: UserModel) -> AnyPublisher<Bool, Error>
    func retriveData() -> AnyPublisher<[UserModel], Error>
}

public class CoreDataInteractor: CoreDataInteractorType {
    private var coreDataInteractor: CoreDataRepositoryType
    
    init(coreDataInteractor: CoreDataRepositoryType) {
        self.coreDataInteractor = coreDataInteractor
    }
    
    public func save(with data: UserModel) -> AnyPublisher<Bool, Error> {
        coreDataInteractor.save(with: data)
    }
    
    public func retriveData() -> AnyPublisher<[UserModel], Error> {
        coreDataInteractor.retriveData()
    }
}
