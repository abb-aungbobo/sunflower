//
//  ProductsScene.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import Foundation

enum ProductsScene {
    static func create() -> ProductsViewController {
        let networkController: NetworkController = NetworkControllerImpl.shared
        let productRepository: ProductRepository = ProductRepositoryImpl(networkController: networkController)
        let viewModel = ProductsViewModel(productRepository: productRepository)
        let router = AppRouter()
        let viewController = ProductsViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
