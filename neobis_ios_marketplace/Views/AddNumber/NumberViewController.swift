//
//  NumberViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 20/6/23.
//

import Foundation
import UIKit
import SnapKit

class NumberViewController: UIViewController{
    
    let mainView = NumberView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
        
    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
