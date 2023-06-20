//
//  ProfileViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 18/6/23.
//

import Foundation
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let mainView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        
        let changeButton = UIBarButtonItem(image: UIImage(named: "change")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(changeButtonPressed))
        self.navigationItem.rightBarButtonItem = changeButton
        
        setupView()
    }
    
    @objc func changeButtonPressed() {
        
    }
    
    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
