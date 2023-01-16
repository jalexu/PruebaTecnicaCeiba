//
//  UserPublishingRepositoryStub.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import Combine
@testable import PruebaTecnicaCeiba

final class UserPublishingRepositoryStub {
    static var response: [UserPublishig]?
    static var error: Error?
}

extension UserPublishingRepositoryStub: UserPublishingRepositoryType {
    func getUserPublishing(idUser: Int) -> AnyPublisher<[PruebaTecnicaCeiba.UserPublishig], Error> {
        let response = UserPublishingRepositoryStub.response ?? Constants.PreviewsMocks.userPusblishings
        let subject = CurrentValueSubject<[UserPublishig], Error>(response)
        
        if let error = UserPublishingRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
}
