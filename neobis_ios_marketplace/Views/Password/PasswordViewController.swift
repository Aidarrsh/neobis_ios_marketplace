//
//  PasswordViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 15/6/23.
//

import Foundation
import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    let mainView = PasswordView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let eyeButton = UIBarButtonItem(image: UIImage(named: "eye-switch")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(eyeButtonPressed))
        self.navigationItem.rightBarButtonItem = eyeButton
        
        title = "Регистрация"
        
        mainView.finishButton.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        
        setupView()
    }
    
    @objc func finishButtonPressed() {
        mainView.passwordError.isHidden = false
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func eyeButtonPressed() {
        mainView.passwordField.isSecureTextEntry = !mainView.passwordField.isSecureTextEntry
        mainView.passwordConfirmField.isSecureTextEntry = !mainView.passwordConfirmField.isSecureTextEntry
    }

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
