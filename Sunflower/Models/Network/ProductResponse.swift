//
//  ProductResponse.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import Foundation

struct ProductResponse: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: RatingResponse
}

extension ProductResponse {
    func toProductContentConfiguration() -> ProductContentConfiguration {
        let formattedPrice = price.formatted(.number.precision(.fractionLength(2)))
        return ProductContentConfiguration(
            image: URL(string: image),
            title: title,
            price: String(format: "$%@", formattedPrice),
            rate: rating.rate.description
        )
    }
    
    func toProductDetailContentConfiguration() -> ProductDetailContentConfiguration {
        let formattedPrice = price.formatted(.number.precision(.fractionLength(2)))
        return ProductDetailContentConfiguration(
            image: URL(string: image),
            title: title,
            description: description,
            price: String(format: "$%@", formattedPrice),
            category: category,
            rate: rating.rate.description
        )
    }
    
    func toProductEntity(quantity: Int) -> ProductEntity {
        let productEntity = ProductEntity()
        productEntity.id = id
        productEntity.title = title
        productEntity.price = price
        productEntity.image = image
        productEntity.quantity = quantity
        return productEntity
    }
}
