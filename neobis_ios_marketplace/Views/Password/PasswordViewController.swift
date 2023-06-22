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
    
    var registerProtocol: RegisterProtocol!
    var username: String = ""
    var email: String = ""
    
    init(registerProtocol: RegisterViewModel) {
        self.registerProtocol = registerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        if mainView.passwordField.text == mainView.passwordConfirmField.text{
            registerProtocol.register(username: username, email: email, password: mainView.passwordField.text!, password_repeat: mainView.passwordConfirmField.text!)
        } else {
            mainView.passwordError.isHidden = false
            mainView.passwordField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
            mainView.passwordConfirmField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        }
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
