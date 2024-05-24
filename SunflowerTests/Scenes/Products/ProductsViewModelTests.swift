//
//  ProductsViewModelTests.swift
//  SunflowerTests
//
//  Created by Aung Bo Bo on 11/03/2024.
//

import XCTest
@testable import Sunflower

final class ProductsViewModelTests: XCTestCase {
    private var sut: ProductsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let productRepository: ProductRepository = ProductRepositoryMock()
        sut = ProductsViewModel(productRepository: productRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_state_whenGetProducts_shouldBeIdleAndLoadingAndSucceeded() async {
        let expected: [ProductsViewModel.State] = [.idle, .loading, .succeeded]
        var results: [ProductsViewModel.State] = []
        
        sut.state
            .sink { state in
                results.append(state)
            }
            .store(in: &sut.cancellables)
        
        await sut.getProducts()
        
        XCTAssert(expected == results, "Results expected to be \(expected) but were \(results)")
    }
    
    func test_products_whenGetProducts_shouldNotBeEmpty() async {
        await sut.getProducts()
        XCTAssertFalse(sut.products.isEmpty)
    }
}
