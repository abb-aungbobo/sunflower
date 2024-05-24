//
//  ProductContentView.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import SnapKit
import UIKit

final class ProductContentView: UIView, UIContentView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let rateImageView = UIImageView()
    private let rateLabel = UILabel()
    
    private var appliedConfiguration: ProductContentConfiguration!
    
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? ProductContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
    
    init(configuration: ProductContentConfiguration) {
        super.init(frame: .zero)
        configureHierarchy()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        configureView()
        configureImageView()
        configureTitleLabel()
        configurePriceLabel()
        configureRateImageView()
        configureRateLabel()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
    }
    
    private func configureImageView() {
        addSubview(imageView)
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
        addSubview(titleLabel)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        priceLabel.adjustsFontForContentSizeCategory = true
        priceLabel.font = .preferredFont(forTextStyle: .subheadline)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
        }
    }
    
    private func configureRateImageView() {
        addSubview(rateImageView)
        rateImageView.image = UIImage(systemName: "star.fill")
        rateImageView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.width.height.equalTo(16)
        }
    }
    
    private func configureRateLabel() {
        addSubview(rateLabel)
        rateLabel.adjustsFontForContentSizeCategory = true
        rateLabel.font = .preferredFont(forTextStyle: .subheadline)
        rateLabel.textColor = .secondaryLabel
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateImageView.snp.trailing).offset(4)
            make.centerY.equalTo(rateImageView)
        }
    }
    
    private func apply(configuration: ProductContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        
        imageView.setImage(with: configuration.image)
        titleLabel.text = configuration.title
        priceLabel.text = configuration.price
        rateLabel.text = configuration.rate
    }
}
