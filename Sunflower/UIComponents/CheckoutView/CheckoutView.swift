//
//  CheckoutView.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 06/03/2024.
//

import SnapKit
import UIKit

protocol CheckoutViewDelegate: AnyObject {
    func didPressCheckoutButton(_ view: CheckoutView)
}

final class CheckoutView: UIView {
    private let separator = UIView()
    private let totalLabel = UILabel()
    private let totalPriceLabel = UILabel()
    private let checkoutButton = UIButton()
    
    weak var delegate: CheckoutViewDelegate?
    
    var totalPrice: Double = 0.0 {
        didSet {
            totalPriceLabel.text = String(format: "$%.2f", totalPrice)
        }
    }
    var isCheckoutButtonEnabled: Bool = true {
        didSet {
            checkoutButton.isEnabled = isCheckoutButtonEnabled
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
        configureTotalLabel()
        configureTotalPriceLabel()
        configureCheckoutButton()
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
    
    private func configureTotalLabel() {
        addSubview(totalLabel)
        totalLabel.adjustsFontForContentSizeCategory = true
        totalLabel.font = .preferredFont(forTextStyle: .headline)
        totalLabel.text = "Total"
        totalLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
    }
    
    private func configureTotalPriceLabel() {
        addSubview(totalPriceLabel)
        totalPriceLabel.adjustsFontForContentSizeCategory = true
        totalPriceLabel.font = .preferredFont(forTextStyle: .headline)
        totalPriceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(totalLabel.snp.centerY)
        }
    }
    
    private func configureCheckoutButton() {
        addSubview(checkoutButton)
        checkoutButton.configuration = UIButton.Configuration.filled()
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonPressed(_:)), for: .touchUpInside)
        checkoutButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func checkoutButtonPressed(_ button: UIButton) {
        delegate?.didPressCheckoutButton(self)
    }
}
