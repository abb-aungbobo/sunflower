//
//  ProductDetailViewModelTests.swift
//  SunflowerTests
//
//  Created by Aung Bo Bo on 11/03/2024.
//

import XCTest
@testable import Sunflower

final class ProductDetailViewModelTests: XCTestCase {
    private var sut: ProductDetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let products: [ProductResponse] = try JSON.decode(from: "products")
        let product: ProductResponse = products[0]
        let cartRepository: CartRepository = CartRepositoryMock(products: [])
        sut = ProductDetailViewModel(product: product, cartRepository: cartRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenSetQuantity_shouldBeIdleAndQuantityChanged() {
        let expected: [ProductDetailViewModel.State] = [.idle, .quantityChanged]
        var results: [ProductDetailViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        sut.set(quantity: 1)
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_state_whenAddToCart_shouldBeIdleAndAddedToCart() async {
        let expected: [ProductDetailViewModel.State] = [.idle, .addedToCart]
        var results: [ProductDetailViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        sut.addToCart()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_quantity_whenSetQuantityOne_shouldBeOne() {
        sut.set(quantity: 1)
        XCTAssert(sut.quantity == 1)
    }
    
    func test_isAddToCartButtonEnabled_whenQuantityIsZero_shouldBeFalse() {
        XCTAssertFalse(sut.isAddToCartButtonEnabled)
    }
    
    func test_isAddToCartButtonEnabled_whenQuantityIsGreaterThanZero_shouldBeTrue() {
        sut.set(quantity: 1)
        XCTAssertTrue(sut.isAddToCartButtonEnabled)
    }
}
