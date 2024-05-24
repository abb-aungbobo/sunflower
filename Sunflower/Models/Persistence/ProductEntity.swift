//
//  ProductEntity.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 05/03/2024.
//

import Foundation
import RealmSwift

final class ProductEntity: EmbeddedObject {
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var price: Double
    @Persisted var image: String
    @Persisted var quantity: Int
    
    var totalPrice: Double {
        price * Double(quantity)
    }
}

extension ProductEntity {
    func toCartItemContentConfiguration() -> CartItemContentConfiguration {
        let formattedPrice = price.formatted(.number.precision(.fractionLength(2)))
        let formattedTotalPrice = totalPrice.formatted(.number.precision(.fractionLength(2)))
        return CartItemContentConfiguration(
            image: URL(string: image),
            title: title,
            price: String(format: "$%@ (total: $%@)", formattedPrice, formattedTotalPrice),
            quantity: Double(quantity)
        )
    }
}
