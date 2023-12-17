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
        let movieService: MovieService = APIManager()
        let viewModel = MovieViewModel(movieService: movieService)

        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "house"), tag: 0)
        let searchVC = SearchViewController(viewModel: viewModel)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        self.viewControllers = [homeVC, searchVC]

    }
    
    
    



}
