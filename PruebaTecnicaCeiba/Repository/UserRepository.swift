//
//  UserRepository.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Alamofire
import Combine
import SwiftUI

public protocol UserRepositoryType {
    func getUser() -> AnyPublisher<[UserModel], Error>
}

public class UserRepository: UserRepositoryType {
    
    private var networkService: NetworkServiceType
    
    public init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    public func getUser() -> AnyPublisher<[UserModel], Error> {
        
        let path = Constants.URLPaths.users
        
        let enpoint = APIRequest<[UserModel]>(
            method: .get,
            relativePath: path,
            parameter: nil,
            parameterEncoding: URLEncoding.default)
        
        return networkService.request(enpoint, queue: .main, retries: 0)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
