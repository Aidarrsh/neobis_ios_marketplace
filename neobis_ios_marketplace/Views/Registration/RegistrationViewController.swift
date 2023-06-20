//
//  RegistrationViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 15/6/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    let mainView = RegistrationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        title = "Регистрация"
        
        setupView()
        mainView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    @objc func enterButtonPressed() {
        
        if mainView.enterButton.backgroundColor != UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1) {
            let vc = PasswordViewController()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

