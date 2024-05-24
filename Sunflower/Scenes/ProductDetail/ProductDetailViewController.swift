//
//  ProductDetailViewController.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import SnapKit
import UIKit

final class ProductDetailViewController: BaseViewController {
    private var cartBarButtonItem: UIBarButtonItem!
    private let addToCartView = AddToCartView()
    private var collectionView: UICollectionView!
    
    private let viewModel: ProductDetailViewModel
    private let router: AppRouter
    
    init(viewModel: ProductDetailViewModel, router: AppRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bind()
    }
    
    private func configureHierarchy() {
        configureView()
        configureCartBarButtonItem()
        configureNavigationItem()
        configureAddToCartView()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCartBarButtonItem() {
        let image = UIImage(systemName: "cart")
        let action = UIAction { [weak self] action in
            self?.cartBarButtonItemPressed()
        }
        cartBarButtonItem = UIBarButtonItem(image: image, primaryAction: action)
    }
    
    private func cartBarButtonItemPressed() {
        router.routeToCart(from: self)
    }
    
    private func configureNavigationItem() {
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = cartBarButtonItem
    }
    
    private func configureAddToCartView() {
        view.addSubview(addToCartView)
        addToCartView.delegate = self
        addToCartView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.register(
            ProductDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductDetailCollectionViewCell.identifier
        )
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addToCartView.snp.top)
        }
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: ProductDetailViewModel.State) {
        switch state {
        case .idle:
            updateAddToCartView()
        case let .failed(error):
            showErrorAlert(error: error)
        case .quantityChanged:
            updateAddToCartView()
        case .addedToCart:
            showAddedToCartAlert()
        }
    }
    
    private func updateAddToCartView() {
        addToCartView.quantity = viewModel.quantity
        addToCartView.isAddToCartButtonEnabled = viewModel.isAddToCartButtonEnabled
    }
    
    private func showAddedToCartAlert() {
        let alertController = UIAlertController(
            title: "Added to cart",
            message: "\(viewModel.product.title) (quantity: \(viewModel.quantity)) added to cart.",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}

// MARK: - AddToCartViewDelegate
extension ProductDetailViewController: AddToCartViewDelegate {
    func didChangeQuantity(_ view: AddToCartView, quantity: Int) {
        viewModel.set(quantity: quantity)
    }
    
    func didPressAddToCartButton(_ view: AddToCartView) {
        viewModel.addToCart()
    }
}

// MARK: - UICollectionViewDataSource
extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductDetailCollectionViewCell.identifier,
            for: indexPath
        ) as! ProductDetailCollectionViewCell
        let configuration = viewModel.product.toProductDetailContentConfiguration()
        cell.configuration = configuration
        return cell
    }
}
