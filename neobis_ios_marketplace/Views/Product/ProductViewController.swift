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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои товары"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        setupView()
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
