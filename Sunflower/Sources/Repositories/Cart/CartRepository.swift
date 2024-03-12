//
//  CartRepository.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 05/03/2024.
//

import Foundation

protocol CartRepository {
    func add(productEntity: ProductEntity) throws
    func getProducts() throws -> [ProductEntity]
    func update(quantity: Int, productEntity: ProductEntity) throws
    func delete(productEntity: ProductEntity) throws
    func delete() throws
}
