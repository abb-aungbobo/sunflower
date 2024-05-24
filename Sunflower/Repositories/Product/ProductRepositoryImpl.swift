//
//  ProductRepositoryImpl.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 03/03/2024.
//

import Foundation

final class ProductRepositoryImpl: ProductRepository {
    private let networkController: NetworkController
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    func getProducts() async throws -> [ProductResponse] {
        let endpoint: ProductsEndpoint = .products
        let response: [ProductResponse] = try await networkController.request(for: endpoint)
        return response
    }
}
