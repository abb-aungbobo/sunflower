//
//  ProductDetailCollectionViewCell.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import UIKit

final class ProductDetailCollectionViewCell: UICollectionViewCell {
    var configuration: ProductDetailContentConfiguration!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = ProductDetailContentConfiguration().updated(for: state)
        newConfiguration.image = configuration.image
        newConfiguration.title = configuration.title
        newConfiguration.description = configuration.description
        newConfiguration.price = configuration.price
        newConfiguration.category = configuration.category
        newConfiguration.rate = configuration.rate
        contentConfiguration = newConfiguration
    }
}
