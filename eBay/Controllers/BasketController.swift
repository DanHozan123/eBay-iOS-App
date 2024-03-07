//
//  BasketViewController.swift
//  eBay
//
//  Created by Dan Hozan on 01.03.2024.
//

import UIKit

class BasketController: UIViewController {

    
    
    // MARK: - Properties

    private var currentUserId: String?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    

    // MARK: - Configurations
    
    private func configure(){
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        title = "Products"
        if let currentUser = UserService.shared.getCurrentUserIdFromLocalMemory() {
            self.currentUserId = currentUser
        }
        else {
            goToSignIn()
        }
        
    }
    
    // MARK: - Navigation
    
    private func goToSignIn(){
        let signInNC = UINavigationController(rootViewController: SignInController())
        signInNC.modalPresentationStyle = .fullScreen
        present(signInNC, animated: true, completion: nil)
    }
    

}
