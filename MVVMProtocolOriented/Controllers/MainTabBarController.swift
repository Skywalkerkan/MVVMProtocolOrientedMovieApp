//
//  MainTabBarController.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 13.09.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "person"), tag: 1)
        
        
        
        self.viewControllers = [homeVC, searchVC]
        
        
        
    }
    



}
