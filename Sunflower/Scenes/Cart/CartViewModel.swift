//
//  CartViewModel.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 06/03/2024.
//

import Combine
import Foundation

final class CartViewModel {
    enum State: Equatable {
        case idle
        case failed(AppError)
        case succeeded
        case totalPriceChanged
        case deleted(IndexPath)
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            case (.totalPriceChanged, .totalPriceChanged): return true
            case (.deleted, .deleted): return true
            default: return false
            }
        }
    }
    
    let title = "Cart"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var totalPrice: Double = 0.0 {
        didSet {
            state.send(.totalPriceChanged)
        }
    }
    
    var isCheckoutButtonEnabled: Bool {
        totalPrice != 0
    }
    
    private(set) var products: [ProductEntity] = []
    
    private let cartRepository: CartRepository
    
    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func getProducts() {
        do {
            let result = try cartRepository.getProducts()
            products = result
            state.send(.succeeded)
            totalPrice = result.map(\.totalPrice).reduce(0, +)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    func update(quantity: Int, productEntity: ProductEntity) {
        do {
            try cartRepository.update(quantity: quantity, productEntity: productEntity)
            getProducts()
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    func delete(at indexPath: IndexPath) {
        products.remove(at: indexPath.item)
        state.send(.deleted(indexPath))
    }
    
    func delete(productEntity: ProductEntity) {
        do {
            try cartRepository.delete(productEntity: productEntity)
            getProducts()
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
    
    func delete() {
        do {
            try cartRepository.delete()
            getProducts()
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
