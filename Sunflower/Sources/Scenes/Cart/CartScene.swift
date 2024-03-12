//
//  CartScene.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 06/03/2024.
//

import Foundation

enum CartScene {
    static func create() -> CartViewController {
        let persistenceController: PersistenceController = PersistenceControllerImpl.shared
        let cartRepository: CartRepository = CartRepositoryImpl(persistenceController: persistenceController)
        let viewModel = CartViewModel(cartRepository: cartRepository)
        let viewController = CartViewController(viewModel: viewModel)
        return viewController
    }
}
