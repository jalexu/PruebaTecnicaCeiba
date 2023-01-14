//
//  UserPublishingViewModel+Inject.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Resolver
extension Resolver {
    
    public static func registerUserPublishingDependencies() {
        registerPublishingInteractorDependencies()
        registerUserPublishingViewModelDependencies()
    }
    
    private static func registerPublishingInteractorDependencies() {
        register(UserPublishingRepositoryType.self) { _ in
            return GeneralRepository.init().userPublishingRepository
        }
        .scope(.application)
        
        register(NetworkServiceType.self) { _ in
            return GeneralRepository.init().networkService
        }
        .scope(.application)
    }
    
    private static func registerUserPublishingViewModelDependencies() {
        register(UserPublishingInteractor.self) { resolver in
            return UserPublishingInteractor(userPublishingRepository: resolver.resolve(UserPublishingRepositoryType.self))
        }
        .scope(.application)
    }
}
