//
//  MainTabBarViewController.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let menuVC = MenuViewController()
    private let contactsVC = ContactsViewController()
    private let profileVC = ProfileViewController()
    private let basketVC = BasketViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        menuVC.tabBarItem.title = "Меню"
        menuVC.tabBarItem.image = UIImage(named: "menu")
        
        contactsVC.tabBarItem.title = "Контакты"
        contactsVC.tabBarItem.image = UIImage(named: "contacts")
        
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(named: "profile")
        
        basketVC.tabBarItem.title = "Корзина"
        basketVC.tabBarItem.image = UIImage(named: "basket")
        
        viewControllers = [menuVC, contactsVC, profileVC, basketVC]
        
        tabBar.layer.backgroundColor = UIColor.white.cgColor
        tabBar.tintColor = UIColor(named: "AccentColor")
        tabBar.unselectedItemTintColor = UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1)
    }
}

