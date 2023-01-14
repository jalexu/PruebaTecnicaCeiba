//
//  GeneralRepository.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation
import Resolver

public class GeneralRepository {
    
    private let urlSession = URLSession(configuration: URLSession.configuration())
    
    public init() {}
    
    public lazy var userPublishingRepository: UserPublishingRepositoryType = {
        UserPublishingRepository(networkService: Resolver.resolve(NetworkServiceType.self))
    }()
    
    public lazy var userRepository: UserRepositoryType = {
        UserRepository(networkService: Resolver.resolve(NetworkServiceType.self))
    }()
    
    public lazy var networkService: NetworkServiceType = {
        NetworkService(urlSession: urlSession, baseURL: URL(string: Constants.URLPaths.baseURL))
    }()
}
