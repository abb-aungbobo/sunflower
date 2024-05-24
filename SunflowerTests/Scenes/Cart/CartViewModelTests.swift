//
//  CartViewModelTests.swift
//  SunflowerTests
//
//  Created by Aung Bo Bo on 11/03/2024.
//

import XCTest
@testable import Sunflower

final class CartViewModelTests: XCTestCase {
    private var sut: CartViewModel!
    private var products: [ProductEntity] = []
    
    override func setUpWithError() throws {
        let response: [ProductResponse] = try JSON.decode(from: "products")
        products = response.prefix(2).map({ $0.toProductEntity(quantity: 1) })
        let cartRepository: CartRepository = CartRepositoryMock(products: products)
        sut = CartViewModel(cartRepository: cartRepository)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_state_whenGetProducts_shouldBeIdleAndSucceededAndTotalPriceChanged() {
        let expected: [CartViewModel.State] = [.idle, .succeeded, .totalPriceChanged]
        var results: [CartViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        sut.getProducts()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_state_whenUpdateProduct_shouldBeIdleAndSucceededAndTotalPriceChanged() {
        let expected: [CartViewModel.State] = [.idle, .succeeded, .totalPriceChanged]
        var results: [CartViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        sut.update(quantity: 1, productEntity: products[0])
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_state_whenDeleteProduct_shouldBeIdleAndSucceededAndTotalPriceChanged() {
        let expected: [CartViewModel.State] = [.idle, .succeeded, .totalPriceChanged]
        var results: [CartViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        sut.delete(productEntity: products[0])
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_state_whenDelete_shouldBeIdleAndSucceededAndTotalPriceChanged() {
        let expected: [CartViewModel.State] = [.idle, .succeeded, .totalPriceChanged]
        var results: [CartViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        sut.delete()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_totalPrice_whenGetProducts_shouldNotBeZero() {
        sut.getProducts()
        XCTAssertFalse(sut.totalPrice.isZero)
    }
    
    func test_isCheckoutButtonEnabled_whenTotalPriceIsZero_shouldBeFalse() {
        XCTAssertFalse(sut.isCheckoutButtonEnabled)
    }
    
    func test_isCheckoutButtonEnabled_whenTotalPriceIsGreaterThanZero_shouldBeTrue() {
        sut.getProducts()
        XCTAssertTrue(sut.isCheckoutButtonEnabled)
    }
    
    func test_products_whenGetProducts_shouldNotBeEmpty() {
        sut.getProducts()
        XCTAssertFalse(sut.products.isEmpty)
    }
}
