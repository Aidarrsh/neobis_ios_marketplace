//
//  FinishRegView.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 19/6/23.
//

import Foundation
import UIKit
import SnapKit

class FinishRegView: UIView {
    
    let profilePic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "defaultPic")
        
        return image
    }()
    
    let firstSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        let firstLineView = UIView()
        firstLineView.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.976, alpha: 1)
        view.addSubview(firstLineView)
        
        firstLineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.centerY.equalTo(44 * UIScreen.main.bounds.height / 812)
            make.height.equalTo(1)
        }
        
        let secondLineView = UIView()
        secondLineView.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.976, alpha: 1)
        view.addSubview(secondLineView)
        
        secondLineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        
        let thirdLineView = UIView()
        thirdLineView.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.976, alpha: 1)
        view.addSubview(thirdLineView)
        
        thirdLineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.centerY.equalTo(134 * UIScreen.main.bounds.height / 812)
            make.height.equalTo(1)
        }
        
        return view
    }()
    
    let secondSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.976, alpha: 1)
        view.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(16 * UIScreen.main.bounds.width / 375)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.976, alpha: 1)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(profilePic)
        addSubview(firstSectionView)
        addSubview(secondSectionView)
    }
    
    func setupConstraints() {
        profilePic.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(112 * UIScreen.main.bounds.height / 812)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(148 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(148 * UIScreen.main.bounds.width / 375)
        }
        
        firstSectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(252 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(381 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        secondSectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(443 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(280 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }

    }
}
