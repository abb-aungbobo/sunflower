//
//  ProductCollectionViewCell.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    var configuration: ProductContentConfiguration!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = ProductContentConfiguration().updated(for: state)
        newConfiguration.image = configuration.image
        newConfiguration.title = configuration.title
        newConfiguration.price = configuration.price
        newConfiguration.rate = configuration.rate
        contentConfiguration = newConfiguration
    }
}
