//
//  ProductRepositoryMock.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import Foundation

final class ProductRepositoryMock: ProductRepository {
    func getProducts() async throws -> [ProductResponse] {
        let response: [ProductResponse] = try JSON.decode(from: "products")
        return response
    }
}
