//
//  ProductDetailContentView.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 04/03/2024.
//

import SnapKit
import UIKit

final class ProductDetailContentView: UIView, UIContentView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let categoryLabel = UILabel()
    private let rateImageView = UIImageView()
    private let rateLabel = UILabel()
    
    private var appliedConfiguration: ProductDetailContentConfiguration!
    
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? ProductDetailContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }
    
    init(configuration: ProductDetailContentConfiguration) {
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
        configureDescriptionLabel()
        configurePriceLabel()
        configureCategoryLabel()
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
            make.width.height.equalTo(96)
        }
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func configurePriceLabel() {
        addSubview(priceLabel)
        priceLabel.adjustsFontForContentSizeCategory = true
        priceLabel.font = .preferredFont(forTextStyle: .headline)
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
        }
    }
    
    private func configureCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.font = .preferredFont(forTextStyle: .subheadline)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
        }
    }
    
    private func configureRateImageView() {
        addSubview(rateImageView)
        rateImageView.image = UIImage(systemName: "star.fill")
        rateImageView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(4)
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
    
    private func apply(configuration: ProductDetailContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration
        
        imageView.setImage(with: configuration.image)
        titleLabel.text = configuration.title
        descriptionLabel.text = configuration.description
        priceLabel.text = configuration.price
        categoryLabel.text = configuration.category
        rateLabel.text = configuration.rate
    }
}
