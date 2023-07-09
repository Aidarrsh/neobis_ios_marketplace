//
//  ProductViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 27/6/23.
//

import Foundation
import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    let containView = ProductView()
    var getProduct: GetProductProtocol!
    
    init(getProduct: GetProductProtocol!) {
        self.getProduct = getProduct
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои товары"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        setupView()
        getProductData()
    }
    
    func getProductData() {
        getProduct.fetchProductData() { [weak self] result in
            switch result {
            case .success(let productData):
//                print(productData)
                self?.parseProductData(productData: productData)
            case .failure(let error):
                print("Failed to fetch product data:", error)
            }
        }
    }
    
    func parseProductData(productData: [[String: Any]]) {
        var products: [[String: Any]] = []
        for data in productData {
            if let id = data["id"] as? Int,
               let user = data["user"] as? String,
               let images = data["images"] as? [String],
               let title = data["title"] as? String,
               let price = data["price"] as? String,
               let likes = data["likes"] as? Int,
               let isFan = data["is_fan"] as? Bool {
                let product: [String: Any] = [
                    "id": id,
                    "user": user,
                    "images": images,
                    "title": title,
                    "price": price,
                    "likes": likes,
                    "isFan": isFan
                ]
                products.append(product)
            }
        }
        
        // Update your collection view with the parsed products
        containView.updateView(with: products)
    }

    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        view.addSubview(containView)
        
        containView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
