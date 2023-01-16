//
//  UserPublishingInteractor.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Combine

public class UserPublishingInteractor: AnyInteractor<Int, [UserPublishig]> {
    private var userPublishingRepository: UserPublishingRepositoryType
    
    public init(userPublishingRepository: UserPublishingRepositoryType) {
        self.userPublishingRepository = userPublishingRepository
    }
    
    public override func execute(params: Int) -> AnyPublisher<[UserPublishig], Error> {
        userPublishingRepository.getUserPublishing(idUser: params)
    }
}
