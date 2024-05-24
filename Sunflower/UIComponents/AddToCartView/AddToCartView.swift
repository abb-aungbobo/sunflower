//
//  AddToCartView.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import SnapKit
import UIKit

protocol AddToCartViewDelegate: AnyObject {
    func didChangeQuantity(_ view: AddToCartView, quantity: Int)
    func didPressAddToCartButton(_ view: AddToCartView)
}

final class AddToCartView: UIView {
    private let separator = UIView()
    private let stepper = UIStepper()
    private let quantityLabel = UILabel()
    private let addToCartButton = UIButton()
    
    weak var delegate: AddToCartViewDelegate?
    
    var quantity: Int = 0 {
        didSet {
            quantityLabel.text = quantity.description
        }
    }
    var isAddToCartButtonEnabled: Bool = true {
        didSet {
            addToCartButton.isEnabled = isAddToCartButtonEnabled
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        configureView()
        configureSeparator()
        configureStepper()
        configureQuantityLabel()
        configureAddToCartButton()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func configureSeparator() {
        addSubview(separator)
        separator.backgroundColor = .separator
        separator.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func configureStepper() {
        addSubview(stepper)
        stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
        stepper.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func stepperChanged(_ sender: UIStepper) {
        let quantity = Int(sender.value)
        delegate?.didChangeQuantity(self, quantity: quantity)
    }
    
    private func configureQuantityLabel() {
        addSubview(quantityLabel)
        quantityLabel.adjustsFontForContentSizeCategory = true
        quantityLabel.font = .preferredFont(forTextStyle: .headline)
        quantityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(stepper.snp.centerY)
        }
    }
    
    private func configureAddToCartButton() {
        addSubview(addToCartButton)
        addToCartButton.configuration = UIButton.Configuration.filled()
        addToCartButton.setTitle("Add to cart", for: .normal)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonPressed(_:)), for: .touchUpInside)
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(stepper.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func addToCartButtonPressed(_ button: UIButton) {
        delegate?.didPressAddToCartButton(self)
    }
}
