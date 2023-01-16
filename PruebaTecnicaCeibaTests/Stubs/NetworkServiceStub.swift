//
//  NetworkServiceStub.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import Foundation
import Combine
@testable import PruebaTecnicaCeiba

final class NetworkServiceStub {
    static var error: Error?
    static var response: AnyObject!
}

extension NetworkServiceStub: NetworkServiceType {
    func request<Response>(_ endpoint: APIRequest<Response>, queue: DispatchQueue, retries: Int) -> AnyPublisher<Response, Error> where Response: Decodable {
        var respObject: Response! = nil
        
        if NetworkServiceStub.response != nil {
            respObject = NetworkServiceStub.response as? Response
        }
        
        let publisher = CurrentValueSubject<Response, Error>(respObject)

        if let error = NetworkServiceStub.error {
            publisher.send(completion: .failure(error))
        }
        
        return publisher.eraseToAnyPublisher()
    }
    
    public func upload<Response>(_ endpoint: APIRequest<Response>,
                          queue: DispatchQueue,
                          retries: Int,
                          fileName: String?,
                          fileExtension: String,
                          mimeType: String) -> AnyPublisher<Response, Error> where Response: Decodable {
        var respObject: Response! = nil
        
        if NetworkServiceStub.response != nil {
            respObject = NetworkServiceStub.response as? Response
        }
        
        let publisher = CurrentValueSubject<Response, Error>(respObject)

        if let error = NetworkServiceStub.error {
            publisher.send(completion: .failure(error))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
