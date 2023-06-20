//
//  FinishRegViewController.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 19/6/23.
//

import Foundation
import UIKit
import SnapKit

class FinishRegViewController: UIViewController {
    
    let mainView = FinishRegView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
