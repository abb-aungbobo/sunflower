//
//  NetworkControllerImpl.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 03/03/2024.
//

import Alamofire
import Foundation

final class NetworkControllerImpl: NetworkController {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    static let shared = NetworkControllerImpl()
    
    private init() {}
    
    func request<T: Codable>(for endpoint: Endpoint) async throws -> T {
        return try await AF
            .request(
                endpoint,
                method: endpoint.method,
                parameters: endpoint.parameters,
                encoding: endpoint.encoding,
                headers: endpoint.headers
            )
            .validate()
            .serializingDecodable(T.self)
            .value
    }
}
