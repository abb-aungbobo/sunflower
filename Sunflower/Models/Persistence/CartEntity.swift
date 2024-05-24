//
//  CartEntity.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 05/03/2024.
//

import RealmSwift

final class CartEntity: Object {
    @Persisted(primaryKey: true) var id: Int = 1
    @Persisted var products: List<ProductEntity> = List<ProductEntity>()
}
