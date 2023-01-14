//
//  CoreData+Inject.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Resolver

extension Resolver {
    
    public static func registerCoreDataDependencies() {
        registerCoreDataRepository()
        registerCoreDataInteractor()
    }
    
    private static func registerCoreDataRepository() {
        register(CoreDataManagerType.self) {
            return CoreDataManager()
        }
        
        register(CoreDataRepositoryType.self) { resolver in
            return CoreDataRepository(coreDataManager: resolver.resolve(CoreDataManagerType.self))
        }
    }
    
    private static func registerCoreDataInteractor() {
        register(CoreDataInteractorType.self) { resolver in
            return CoreDataInteractor(coreDataInteractor: resolver.resolve(CoreDataRepositoryType.self))
        }
    }
}
