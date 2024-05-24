//
//  CartViewController.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 06/03/2024.
//

import SnapKit
import UIKit

final class CartViewController: BaseViewController {
    private let checkoutView = CheckoutView()
    private var collectionView: UICollectionView!
    
    private let viewModel: CartViewModel
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bind()
        viewModel.getProducts()
    }
    
    private func configureHierarchy() {
        configureView()
        configureNavigationItem()
        configureCheckoutView()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationItem() {
        navigationItem.title = viewModel.title
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureCheckoutView() {
        view.addSubview(checkoutView)
        checkoutView.delegate = self
        checkoutView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureCollectionView() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
            let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
                self?.delete(at: indexPath)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [delete])
        }
        let collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.register(
            CartItemCollectionViewCell.self,
            forCellWithReuseIdentifier: CartItemCollectionViewCell.identifier
        )
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(checkoutView.snp.top)
        }
    }
    
    private func bind() {
        viewModel.state
            .sink { [weak self] state in
                self?.render(state: state)
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func render(state: CartViewModel.State) {
        switch state {
        case .idle:
            clearContentUnavailableConfiguration()
            updateCheckoutView()
        case let .failed(error):
            clearContentUnavailableConfiguration()
            showErrorAlert(error: error)
        case .succeeded:
            if viewModel.products.isEmpty {
                showEmpty()
            } else {
                clearContentUnavailableConfiguration()
            }
            collectionView.reloadData()
        case .totalPriceChanged:
            updateCheckoutView()
        case let .deleted(indexPath):
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    private func updateCheckoutView() {
        checkoutView.totalPrice = viewModel.totalPrice
        checkoutView.isCheckoutButtonEnabled = viewModel.isCheckoutButtonEnabled
    }
    
    private func showEmpty() {
        var empty = UIContentUnavailableConfiguration.empty()
        empty.background.backgroundColor = .systemBackground
        empty.image = UIImage(systemName: "cart.fill")
        empty.text = "Your cart is empty"
        contentUnavailableConfiguration = empty
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    private func delete(at indexPath: IndexPath) {
        let product = viewModel.products[indexPath.item]
        viewModel.delete(at: indexPath)
        viewModel.delete(productEntity: product)
    }
}

// MARK: - CheckoutViewDelegate
extension CartViewController: CheckoutViewDelegate {
    func didPressCheckoutButton(_ view: CheckoutView) {
        let alertController = UIAlertController(
            title: "Order Successful",
            message: "Thank you so much for your order.",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            self?.viewModel.delete()
            self?.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CartItemCollectionViewCell.identifier,
            for: indexPath
        ) as! CartItemCollectionViewCell
        cell.delegate = self
        let configuration = viewModel.products[indexPath.item].toCartItemContentConfiguration()
        cell.configuration = configuration
        return cell
    }
}

// MARK: - CartItemCollectionViewCellDelegate
extension CartViewController: CartItemCollectionViewCellDelegate {
    func didChangeQuantity(_ collectionViewCell: CartItemCollectionViewCell, quantity: Int) {
        guard let indexPath = collectionView.indexPath(for: collectionViewCell) else { return }
        let product = viewModel.products[indexPath.item]
        viewModel.update(quantity: quantity, productEntity: product)
    }
}
