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
    var nickName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"
        
        let changeButton = UIBarButtonItem(image: UIImage(named: "change")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(changeButtonPressed))
        self.navigationItem.rightBarButtonItem = changeButton
        
        mainView.nickLabel.text = nickName
        print(1,nickName)
        
        mainView.finishbutton.addTarget(self, action: #selector(finishRegPressed), for: .touchUpInside)
        
        setupView()
    }
    
    @objc func finishRegPressed() {
        let vc = FinishRegViewController()
        
        navigationController?.pushViewController(vc, animated: true)
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
