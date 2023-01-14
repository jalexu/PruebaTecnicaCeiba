//
//  userViewModel+Inject.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Resolver

extension Resolver {
    public static func registerUserDependencies() {
        registerUserInteractorDependencies()
        registerUserViewModelDependencies()
        registerUserViewModel()
    }
    
    private static func registerUserInteractorDependencies() {
        register(NetworkServiceType.self) { _ in
            return GeneralRepository.init().networkService
        }
        register(UserRepositoryType.self) { _ in
            return GeneralRepository.init().userRepository
        }
    }
    
    private static func registerUserViewModelDependencies() {
        register(UserInteractor.self) { resolver in
            return UserInteractor(userRepository: resolver.resolve(UserRepositoryType.self))
        }
    }
    
    private static func registerUserViewModel() {
        register(UserViewModel.self) { resolver in
            UserViewModel(getUsersInteractor: resolver.resolve(UserInteractor.self),
                          coreDataInteractor: resolver.resolve(CoreDataRepositoryType.self))
        }
    }
}
