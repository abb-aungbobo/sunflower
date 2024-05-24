//
//  ProductDetailContentConfiguration.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import UIKit

struct ProductDetailContentConfiguration: UIContentConfiguration, Hashable {
    var image: URL?
    var title: String?
    var description: String?
    var price: String?
    var category: String?
    var rate: String?
    
    func makeContentView() -> UIView & UIContentView {
        return ProductDetailContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> ProductDetailContentConfiguration {
        let updatedConfig = self
        return updatedConfig
    }
}
