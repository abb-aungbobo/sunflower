//
//  ProductDetailScene.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import Foundation

enum ProductDetailScene {
    static func create(product: ProductResponse) -> ProductDetailViewController {
        let persistenceController: PersistenceController = PersistenceControllerImpl.shared
        let cartRepository: CartRepository = CartRepositoryImpl(persistenceController: persistenceController)
        let viewModel = ProductDetailViewModel(product: product, cartRepository: cartRepository)
        let router = AppRouter()
        let viewController = ProductDetailViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
