//
//  ProfileViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 18/6/23.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class ProfileViewController: UIViewController {
    
    let mainView = ProfileView()
    var nickName: String = ""
    var getUserProtocol: GetUserProtocol!
    
    init(getUserProtocol: GetUserProtocol!) {
        self.getUserProtocol = getUserProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        
        let changeButton = UIBarButtonItem(image: UIImage(named: "change")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(changeButtonPressed))
        self.navigationItem.rightBarButtonItem = changeButton
        
        mainView.finishbutton.addTarget(self, action: #selector(finishRegPressed), for: .touchUpInside)
        mainView.exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        
        getUserData()
        checkFullRegister()
        setupView()
    }
    
    func getUserData() {
        guard let accessToken = AuthManager.shared.accessToken else {
            return
        }
        
        print(accessToken)
        
        getUserProtocol.fetchUserData(accessToken: accessToken) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.parseUserData(userData)
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }

    func parseUserData(_ userData: [String: Any]) {
        if let username = userData["username"] as? String {
            self.nickName = username
            DispatchQueue.main.async {
                self.mainView.nickLabel.text = username
            }
        }
    }
    
    func checkFullRegister() {
        guard let accessToken = AuthManager.shared.accessToken else {
            return
        }

        getUserProtocol.fetchUserData(accessToken: accessToken) { [weak self] result in
            switch result {
            case .success(let userData):
                if let phoneNumber = userData["phone_number"] as? String {
//                    print("Phone number:", phoneNumber)
                    DispatchQueue.main.async {
                        self?.mainView.finishbutton.isHidden = true
                    }
                }
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }
    
    @objc func finishRegPressed() {
        let vc = FinishRegViewController(getUserProtocol: GetUserViewModel())
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeButtonPressed() {
        let vc = FinishRegViewController(getUserProtocol: GetUserViewModel())
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func exitButtonPressed() {
        let vc = CustomTabBarC()
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
