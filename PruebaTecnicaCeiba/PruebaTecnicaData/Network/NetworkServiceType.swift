//
//  NetworkServiceType.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation
import Combine

public protocol NetworkServiceType {
    func request<Response>(_ enpoint: APIRequest<Response>,
                           queue: DispatchQueue,
                           retries: Int) -> AnyPublisher<Response, Error> where Response: Codable
}
