//
//  NetworkService.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation
import Alamofire
import Combine

public class NetworkService {
    private var urlSession: URLSession
    private var baseURL: URL?
    
    public init(urlSession: URLSession, baseURL: URL? = nil) {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }
    
    public func setBaseUrl(_ baseUrl: String) {
        baseURL = URL(string: baseUrl)
    }
    
    private func getHeaders<Response>(_ request: APIRequest<Response>) -> Alamofire.HTTPHeaders {
        var headers = Alamofire.HTTPHeaders.default
       
        headers[Constants.APIClient.contentType] = request.contentType.rawValue
        
        return headers
    }
    
    private func getBaseUrl(path: String, parameters: [String: Any] = [:]) -> URL? {
       guard let baseURL = baseURL?.appendingPathComponent(path)
                .absoluteString.removingPercentEncoding else { return nil }

        var urlComponents = URLComponents(url: URL(string: baseURL)!, resolvingAgainstBaseURL: true)!

        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }

        return urlComponents.url
    }
    
    private func getURLRequest<Response>(_ endpoint: APIRequest<Response>) -> URLRequest? {
        var url: URL?
        var httpBody: Data?
        
        if let parameters = endpoint.parameter {
            if endpoint.method != .get {
                let body = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                httpBody = body
                url = URL(string: endpoint.relativePath)
            } else {
                url = URL(string: endpoint.relativePath)
            }
        } else {
            url = getBaseUrl(path: endpoint.relativePath)
        }
        
        guard let requestUrl: URL = url else { return nil }
        
        let headers = getHeaders(endpoint)
        
        var request = URLRequest(url: requestUrl)
        request.httpBody = httpBody
        request.allHTTPHeaderFields = headers.dictionary
        request.httpMethod = endpoint.method.rawValue
        
        return request
    }
}

extension NetworkService: NetworkServiceType {
    
    public func request<Response>(_ endpoint: APIRequest<Response>,
                                queue: DispatchQueue = .main,
                                retries: Int = 0) -> AnyPublisher<Response, Error> where Response: Decodable
    {
        guard let request = getURLRequest(endpoint) else {
            return Fail<Response, Error>(error: CostumErrors.ApiRequest.pageNotFound)
                .eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw CostumErrors.ApiRequest.serverError
                }
                
                if !(200 ..< 300 ~= httpResponse.statusCode) {
                    
                    let statusCode = CostumErrors.StatusCodes(from: httpResponse.statusCode)
                    let error = CostumErrors.ApiRequest(statusCode: statusCode)
                    
                    debugPrint("Error Endpoint: \(request.url?.absoluteString ?? "")")
                    
                    if var resString = String(data: data, encoding: .utf8) {
                        resString.removeAll(where: { $0 == "\\" })
                        debugPrint("** Error Response data: ** : \(resString)")
                    }
                    
                    throw error ?? .serverError
                }
                
                return data
            }
            .decode(type: Response.self, decoder: decoder)
            .receive(on: queue)
            .retry(retries)
            .mapError {
                let erro = $0 as? URLError
                let statusCode = CostumErrors.StatusCodes(from: erro?.errorCode ?? 0)
                let error = CostumErrors.ApiRequest(statusCode: statusCode)
                return error!
            }
            .eraseToAnyPublisher()
    }
}
