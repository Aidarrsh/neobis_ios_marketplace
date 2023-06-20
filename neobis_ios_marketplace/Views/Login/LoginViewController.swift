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
        
//        loginViewModel.loginResult = { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let data):
//                    // Handle successful login and pass the data to the next view controller
//                    self?.handleSuccessfulLogin(data)
//                case .failure(let error):
//                    // Handle login failure
//                    self?.handleLoginFailure(error)
//                }
//            }
//        }
    }
    
    @objc func enterButtonPressed() {
        
        guard let name = mainView.nameField.text, let password = mainView.passwordField.text else {
            print("Email or password is empty.")
            return
        }
        
        loginViewModel.login(username: name, password: password)
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
