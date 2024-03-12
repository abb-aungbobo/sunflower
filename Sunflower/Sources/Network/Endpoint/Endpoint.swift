//
//  Endpoint.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 03/03/2024.
//

import Alamofire

protocol Endpoint: URLConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}
