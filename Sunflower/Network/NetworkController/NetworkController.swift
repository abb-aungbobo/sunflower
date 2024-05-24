//
//  NetworkController.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 03/03/2024.
//

import Foundation

protocol NetworkController {
    func request<T: Codable>(for endpoint: Endpoint) async throws -> T
}
