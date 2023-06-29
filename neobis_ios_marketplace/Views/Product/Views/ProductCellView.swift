//
//  ProductCellView.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 29/6/23.
//

import UIKit
import SnapKit

class ProductCellView: UICollectionViewCell {
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "bmw")
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.text = "Product"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "12000"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12 * UIScreen.main.bounds.height / 812
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(priceLabel)
    }
    
    func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(6 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(93 * UIScreen.main.bounds.height / 812)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
}
