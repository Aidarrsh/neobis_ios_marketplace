//
//  ViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 13/6/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let mainView = LoginView()
    var loginViewModel: LoginViewModel!

    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        mainView.registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        mainView.enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        
        loginViewModel.loginResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.handleSuccessfulLogin(data)
                case .failure(let error):
                    self?.handleLoginFailure(error)
                }
            }
        }
    }
    
    @objc func enterButtonPressed() {
        
        if mainView.enterButton.backgroundColor != UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1) {
            
            guard let name = mainView.nameField.text, let password = mainView.passwordField.text else {
                print("Email or password is empty.")
                return
            }
            
            loginViewModel.login(username: name, password: password)
        }
    }
    
    func handleSuccessfulLogin(_ data: Data) {
        
        let vc = CustomTabBarC()
        vc.modalPresentationStyle = .fullScreen
        
        if let viewControllers = vc.viewControllers {
            let lastIndex = viewControllers.count - 1
            vc.selectedIndex = lastIndex
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    func handleLoginFailure(_ error: Error) {
        mainView.statusLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mainView.statusLabel.isHidden = true
        }
        
        mainView.nameField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        mainView.passwordField.textColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        mainView.nameLine.backgroundColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        mainView.passwordLine.backgroundColor = UIColor(red: 0.954, green: 0.27, blue: 0.27, alpha: 1)
        print("Login failed with error: \(error)")
    }

    @objc func registerButtonPressed() {
        let vc = RegistrationViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
