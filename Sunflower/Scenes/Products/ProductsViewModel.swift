//
//  ProductsViewModel.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import Combine

final class ProductsViewModel {
    enum State: Equatable {
        case idle
        case loading
        case failed(AppError)
        case succeeded
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.loading, .loading): return true
            case (.failed, .failed): return true
            case (.succeeded, .succeeded): return true
            default: return false
            }
        }
    }
    
    let title = "Sunflower"
    let state = CurrentValueSubject<State, Never>(.idle)
    var cancellables: Set<AnyCancellable> = []
    
    private(set) var products: [ProductResponse] = []
    
    private let productRepository: ProductRepository
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    @MainActor func getProducts() async {
        state.send(.loading)
        do {
            let result = try await productRepository.getProducts()
            products = result
            state.send(.succeeded)
        } catch {
            state.send(.failed(error.toAppError()))
        }
    }
}
