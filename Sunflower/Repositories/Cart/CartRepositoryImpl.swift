//
//  CartRepositoryImpl.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 05/03/2024.
//

import Foundation

final class CartRepositoryImpl: CartRepository {
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func add(productEntity: ProductEntity) throws {
        if let cartEntity = try persistenceController.get(ofType: CartEntity.self, forPrimaryKey: 1) {
            if let entity = cartEntity.products.first(where: { entity in entity.id == productEntity.id }) {
                try persistenceController.update {
                    entity.quantity = entity.quantity + productEntity.quantity
                }
            } else {
                try persistenceController.update {
                    cartEntity.products.append(productEntity)
                }
            }
        } else {
            let cartEntity = CartEntity()
            cartEntity.products.append(productEntity)
            try persistenceController.add(entity: cartEntity)
        }
    }
    
    func getProducts() throws -> [ProductEntity] {
        if let cartEntity = try persistenceController.get(ofType: CartEntity.self, forPrimaryKey: 1) {
            return Array(cartEntity.products)
        } else {
            return []
        }
    }
    
    func update(quantity: Int, productEntity: ProductEntity) throws {
        if let cartEntity = try persistenceController.get(ofType: CartEntity.self, forPrimaryKey: 1) {
            if let entity = cartEntity.products.first(where: { entity in entity.id == productEntity.id }) {
                try persistenceController.update {
                    entity.quantity = quantity
                }
            } else {
                throw AppError.generic
            }
        } else {
            throw AppError.generic
        }
    }
    
    func delete(productEntity: ProductEntity) throws {
        if let cartEntity = try persistenceController.get(ofType: CartEntity.self, forPrimaryKey: 1) {
            if let index = cartEntity.products.firstIndex(where: { entity in entity.id == productEntity.id }) {
                try persistenceController.update {
                    cartEntity.products.remove(at: index)
                }
            } else {
                throw AppError.generic
            }
        } else {
            throw AppError.generic
        }
    }
    
    func delete() throws {
        if let cartEntity = try persistenceController.get(ofType: CartEntity.self, forPrimaryKey: 1) {
            try persistenceController.delete(entity: cartEntity)
        } else {
            throw AppError.generic
        }
    }
}
