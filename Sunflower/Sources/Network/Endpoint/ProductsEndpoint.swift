//
//  ProductsEndpoint.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 03/03/2024.
//

import Alamofire
import Foundation

enum ProductsEndpoint: Endpoint {
    case products
    
    var path: String {
        switch self {
        case .products:
            return "products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        [:]
    }
    
    func asURL() throws -> URL {
        return Environment.apiBaseURL.appendingPathComponent(path)
    }
}
