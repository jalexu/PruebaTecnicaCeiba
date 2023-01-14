//
//  UserInteractor.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Combine

public class UserInteractor: AnyInteractor<Any?, [UserModel]> {
    private var userRepository: UserRepositoryType
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
    }
    
    public override func execute(params: Any?) -> AnyPublisher<[UserModel], Error> {
        return userRepository.getUser()
    }
}
