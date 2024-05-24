//
//  ProductContentConfiguration.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import UIKit

struct ProductContentConfiguration: UIContentConfiguration, Hashable {
    var image: URL?
    var title: String?
    var price: String?
    var rate: String?
    
    func makeContentView() -> UIView & UIContentView {
        return ProductContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> ProductContentConfiguration {
        let updatedConfig = self
        return updatedConfig
    }
}
