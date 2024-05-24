//
//  CartItemCollectionViewCell.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 06/03/2024.
//

import SnapKit
import UIKit

protocol CartItemCollectionViewCellDelegate: AnyObject {
    func didChangeQuantity(_ collectionViewCell: CartItemCollectionViewCell, quantity: Int)
}

final class CartItemCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let stepper = UIStepper()
    private let quantityLabel = UILabel()
    
    weak var delegate: CartItemCollectionViewCellDelegate?
    
    var configuration: CartItemContentConfiguration! {
        didSet {
            apply(configuration: configuration)
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
        configureImageView()
        configureTitleLabel()
        configurePriceLabel()
        configureStepper()
        configureQuantityLabel()
    }
    
    private func configureView() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func configureImageView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 8.0
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.width.height.equalTo(96)
        }
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func configurePriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.adjustsFontForContentSizeCategory = true
        priceLabel.font = .preferredFont(forTextStyle: .subheadline)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
        }
    }
    
    private func configureStepper() {
        contentView.addSubview(stepper)
        stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
        stepper.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func stepperChanged(_ sender: UIStepper) {
        let quantity = Int(sender.value)
        delegate?.didChangeQuantity(self, quantity: quantity)
    }
    
    private func configureQuantityLabel() {
        contentView.addSubview(quantityLabel)
        quantityLabel.adjustsFontForContentSizeCategory = true
        quantityLabel.font = .preferredFont(forTextStyle: .headline)
        quantityLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.centerY.equalTo(stepper.snp.centerY)
        }
    }
    
    private func apply(configuration: CartItemContentConfiguration) {
        imageView.setImage(with: configuration.image)
        titleLabel.text = configuration.title
        priceLabel.text = configuration.price
        stepper.value = configuration.quantity ?? .zero
        quantityLabel.text = Int(stepper.value).description
    }
}
