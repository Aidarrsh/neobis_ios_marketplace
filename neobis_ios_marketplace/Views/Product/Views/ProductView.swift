//
//  ProductView.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 27/6/23.
//

import Foundation
import UIKit
import SnapKit

class ProductView: UIView {
    
    var products: [[String: Any]] = []
    
    let boxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Artwork")
        image.isHidden = true
        return image
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ой пусто!"
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(boxImage)
        addSubview(emptyLabel)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        boxImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(184 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(96 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(111 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(443 * UIScreen.main.bounds.height / 812)
        }
        
        emptyLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(413 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(35 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview().inset(382 * UIScreen.main.bounds.height / 812)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(112 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateView(with products: [[String: Any]]) {
        self.products = products
        if products.isEmpty {
            emptyLabel.isHidden = false
            collectionView.isHidden = true
        } else {
            emptyLabel.isHidden = true
            collectionView.isHidden = false
            
            collectionView.reloadData()
        }
    }
}

extension ProductView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
        
        let product = products[indexPath.item]
        
        if let title = product["title"] as? String {
            cell.productNameLabel.text = title
        }
        
        if let price = product["price"] as? String {
            cell.priceLabel.text = price
        }
        
        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.productImageView.image = UIImage(named: "defaultImage")
                    }
                }
            }.resume()
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 161 * UIScreen.main.bounds.width / 375
        let cellHeight = 184 * UIScreen.main.bounds.height / 812
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
