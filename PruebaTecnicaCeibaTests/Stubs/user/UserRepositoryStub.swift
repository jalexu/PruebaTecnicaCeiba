//
//  UserRepositoryStub.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import Combine
@testable import PruebaTecnicaCeiba

final class UserRepositoryStub {
    static var response: [UserModel]?
    static var error: Error?
}

extension UserRepositoryStub: UserRepositoryType {
    func getUser() -> AnyPublisher<[PruebaTecnicaCeiba.UserModel], Error> {
        let response = UserRepositoryStub.response ?? Constants.PreviewsMocks.users
        let subject = CurrentValueSubject<[UserModel], Error>(response)
        
        if let error = UserRepositoryStub.error {
            subject.send(completion: .failure(error))
        }
        
        return subject.eraseToAnyPublisher()
    }
}
