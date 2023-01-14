//
//  CoreDataRepository.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Combine

public protocol CoreDataRepositoryType {
    func save(with data: UserModel) -> AnyPublisher<Bool, Error>
    func retriveData() -> AnyPublisher<[UserModel], Error>
}

public class CoreDataRepository: CoreDataRepositoryType {
    private let coreDataManager: CoreDataManagerType
    
    init(coreDataManager: CoreDataManagerType) {
        self.coreDataManager = coreDataManager
    }
    
    public func save(with data: UserModel) -> AnyPublisher<Bool, Error> {
        coreDataManager.save(with: data)
    }
    
    public func retriveData() -> AnyPublisher<[UserModel], Error> {
        coreDataManager.retriveData()
    }
}
