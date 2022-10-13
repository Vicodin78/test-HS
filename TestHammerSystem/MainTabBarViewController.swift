//
//  MainTabBarViewController.swift
//  TestHammerSystem
//
//  Created by Vicodin on 13.10.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let menuVC = MenuViewController()
    let contactsVC = ContactsViewController()
    let profileVC = ProfileViewController()
    let basketVC = BasketViewController()

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
    }
}

