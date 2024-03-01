//
//  MainTabBarController.swift
//  eBay
//
//  Created by Dan Hozan on 01.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    // MARK: - Properties
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarConfigure()
    }
    
    // MARK: - Configurations
    func tabBarConfigure() {
        
        let categoriesNC = UINavigationController(rootViewController: CategoriesViewController())
        categoriesNC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let searchNC = UINavigationController(rootViewController: SearchViewController())
        searchNC.tabBarItem = UITabBarItem(title: "Seach", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)

        let basketNC = UINavigationController(rootViewController: BasketViewController())
        basketNC.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), selectedImage: UIImage(systemName: "basket.fill"))

        let profileNC = UINavigationController(rootViewController: ProfileViewController())
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))

        
        self.viewControllers = [categoriesNC, searchNC, basketNC, profileNC]
        
        tabBar.tintColor = .black

        
    }

}
