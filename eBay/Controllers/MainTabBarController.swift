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
        
        let layout = UICollectionViewFlowLayout()
        let categoriesNC = UINavigationController(rootViewController: CategoriesController(collectionViewLayout: layout))
        categoriesNC.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
       
        let searchNC = UINavigationController(rootViewController: SearchController())
        searchNC.tabBarItem = UITabBarItem(title: "Seach", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        
        let favoritesNC = UINavigationController(rootViewController: FavoritesController())
        favoritesNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))

        let basketNC = UINavigationController(rootViewController: BasketController())
        basketNC.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "basket"), selectedImage: UIImage(systemName: "basket.fill"))

        let profileNC = UINavigationController(rootViewController: ProfileController())
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))

        
        self.viewControllers = [categoriesNC, searchNC, favoritesNC, basketNC, profileNC]
        
        tabBar.tintColor = .black
    }

}
