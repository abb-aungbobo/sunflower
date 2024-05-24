//
//  ProductRepository.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import Foundation

protocol ProductRepository {
    func getProducts() async throws -> [ProductResponse]
}
