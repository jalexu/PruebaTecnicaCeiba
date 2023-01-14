//
//  UserPublishingRepository.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Alamofire
import Combine
import SwiftUI

public protocol UserPublishingRepositoryType {
    func getUserPublishing(idUser: Int) -> AnyPublisher<[UserPublishig], Error>
}

public class UserPublishingRepository: UserPublishingRepositoryType {
    
    private var networkService: NetworkServiceType
    
    public init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    public func getUserPublishing(idUser: Int) -> AnyPublisher<[UserPublishig], Error> {
        let path = Constants.URLPaths.publishing + "\(idUser)"
        
        let enpoint = APIRequest<[UserPublishig]>(
            method: .get,
            relativePath: path,
            parameter: nil,
            parameterEncoding: URLEncoding.default)
        
        return networkService.request(enpoint, queue: .main, retries: 0)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
