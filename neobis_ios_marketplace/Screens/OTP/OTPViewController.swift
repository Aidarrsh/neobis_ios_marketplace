//
//  OTPViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 25/6/23.
//

import Foundation
import UIKit
import SnapKit

class OTPViewController: UIViewController{
    
    let mainView = OTPView()
    
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
