//
//  ProductDetailViewModel.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import Combine

final class ProductDetailViewModel {
    enum State: Equatable {
        case idle
        case failed(AppError)
        case quantityChanged
        case addedToCart
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.failed, .failed): return true
            case (.quantityChanged, .quantityChanged): return true
            case (.addedToCart, .addedToCart): return true
            default: return false
            }
        }
    }
    
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var quantity: Int = 0 {
        didSet {
            state.send(.quantityChanged)
        }
    }
    
    var isAddToCartButtonEnabled: Bool {
        quantity != 0
    }
    
    let product: ProductResponse
    
    private let cartRepository: CartRepository
    
    init(product: ProductResponse, cartRepository: CartRepository) {
        self.product = product
        self.cartRepository = cartRepository
    }
    
    func set(quantity: Int) {
        self.quantity = quantity
    }
    
    func addToCart() {
        do {
            let productEntity = product.toProductEntity(quantity: quantity)
            try cartRepository.add(productEntity: productEntity)
            state.send(.addedToCart)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
