//
//  ProductsViewController.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import SnapKit
import UIKit

final class ProductsViewController: BaseViewController {
    private var cartBarButtonItem: UIBarButtonItem!
    private var collectionView: UICollectionView!
    
    private let viewModel: ProductsViewModel
    private let router: AppRouter
    
    init(viewModel: ProductsViewModel, router: AppRouter) {
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
        
        Task {
            await viewModel.getProducts()
        }
    }
    
    private func configureHierarchy() {
        configureView()
        configureCartBarButtonItem()
        configureNavigationItem()
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
        navigationItem.title = viewModel.title
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = cartBarButtonItem
    }
    
    private func configureCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: ProductsViewModel.State) {
        switch state {
        case .idle:
            clearContentUnavailableConfiguration()
        case .loading:
            showLoading()
        case let .failed(error):
            clearContentUnavailableConfiguration()
            showErrorAlert(error: error)
        case .succeeded:
            clearContentUnavailableConfiguration()
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.identifier,
            for: indexPath
        ) as! ProductCollectionViewCell
        let configuration = viewModel.products[indexPath.item].toProductContentConfiguration()
        cell.configuration = configuration
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.item]
        router.routeToProductDetail(from: self, product: product)
    }
}
