//
//  NumberView.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 20/6/23.
//

import Foundation
import UIKit
import SnapKit

class NumberView: UIView {
    
    let phoneView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        view.layer.cornerRadius = 20 * UIScreen.main.bounds.height / 812
        
        view.layer.shadowColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4
        
        return view
    }()

    
    let phoneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "call")
        
        return image
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите номер телефона"
        label.font = UIFont(name: "GothamPro-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправим вам СМС с кодом подтверждения"
        label.font = UIFont(name: "GothamPro", size: 16)
        label.textColor = UIColor(red: 0.754, green: 0.754, blue: 0.754, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(phoneView)
        addSubview(phoneImage)
        addSubview(mainLabel)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        phoneView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(120 * UIScreen.main.bounds.height / 812)            
            make.bottom.equalToSuperview().inset(612 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(147.5 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(147.5 * UIScreen.main.bounds.width / 375)
        }
        
        phoneImage.snp.makeConstraints{ make in
            make.center.equalTo(phoneView.snp.center)
            make.height.equalTo(36 * UIScreen.main.bounds.height / 812)
            make.width.equalTo(36 * UIScreen.main.bounds.width / 375)
        }
        
        mainLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(232 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(561 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
        
        descriptionLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(263 * UIScreen.main.bounds.height / 812)
            make.bottom.equalToSuperview().inset(511 * UIScreen.main.bounds.height / 812)
            make.leading.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
            make.trailing.equalToSuperview().inset(20 * UIScreen.main.bounds.width / 375)
        }
    }
}
