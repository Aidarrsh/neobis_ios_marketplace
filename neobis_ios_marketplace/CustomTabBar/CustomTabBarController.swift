//
//  ProfileTabBar.swift
//  neobis_ios_marketplace
//
//  Created by Айдар Шарипов on 18/6/23.
//

import Foundation
import UIKit

class CustomTabBarC: UITabBarController {
    
    var nickName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        let customTabBar = CustomTabBar()
        customTabBar.tintColor = UIColor(red: 0.329, green: 0.345, blue: 0.918, alpha: 1)
        customTabBar.backgroundColor = .white
        self.setValue(customTabBar, forKey: "tabBar")
        
        let homeVC = UIViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home"), selectedImage: nil)
        
        let categoriesVC = UIViewController()
        categoriesVC.view.backgroundColor = .white
        categoriesVC.tabBarItem = UITabBarItem(title: "Кошелек", image: UIImage(named: "wallet"), selectedImage: nil)
        
        let cartVC = UIViewController()
        cartVC.view.backgroundColor = .white
        cartVC.tabBarItem = UITabBarItem(title: "Чаты", image: UIImage(named: "chat"), selectedImage: nil)
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.view.backgroundColor = .white
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "user"), selectedImage: nil)
        
        viewControllers = [homeVC, categoriesVC, cartVC, profileVC]
    }
}