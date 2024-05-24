//
//  CartRepositoryMock.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 07/03/2024.
//

import Foundation

final class CartRepositoryMock: CartRepository {
    private var products: [ProductEntity] = []
    
    init(products: [ProductEntity]) {
        self.products = products
    }
    
    func add(productEntity: ProductEntity) throws {
        products.append(productEntity)
    }
    
    func getProducts() throws -> [ProductEntity] {
        return products
    }
    
    func update(quantity: Int, productEntity: ProductEntity) throws {
        if let product = products.first(where: { entity in entity.id == productEntity.id }) {
            product.quantity = quantity
        } else {
            throw AppError.generic
        }
    }
    
    func delete(productEntity: ProductEntity) throws {
        if let index = products.firstIndex(where: { entity in entity.id == productEntity.id }) {
            products.remove(at: index)
        } else {
            throw AppError.generic
        }
    }
    
    func delete() throws {
        products.removeAll()
    }
}
