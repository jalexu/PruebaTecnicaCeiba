//
//  APIRequest.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation
import Alamofire

public class APIRequest<Response> {
    public let method: HTTPMethod
    public let relativePath: String
    public let parameter: [String: Any]?
    public let parameterEncoding: ParameterEncoding
    public let contentType: APIContentType
    public let decode: (Data) throws -> Response
    
    public init(
        method: HTTPMethod,
        relativePath: String,
        parameter: [String : Any]?,
        parameterEncoding: ParameterEncoding,
        contentType: APIContentType = APIContentType.json,
        decode: @escaping (Data) throws -> Response)
    {
        self.method = method
        self.relativePath = relativePath
        self.parameter = parameter
        self.parameterEncoding = parameterEncoding
        self.contentType = contentType
        self.decode = decode
        
    }
}

public extension APIRequest where Response: Decodable {
    convenience init(method: HTTPMethod,
                     relativePath: String,
                     parameter: [String : Any]?,
                     parameterEncoding: ParameterEncoding,
                     contentType: APIContentType = APIContentType.json)
    {
        self.init(method: method,
                  relativePath: relativePath,
                  parameter: parameter,
                  parameterEncoding: parameterEncoding,
                  contentType: contentType) {
            let decoder = JSONDecoder()
            return try decoder.decode(Response.self, from: $0)
        }
    }
}
