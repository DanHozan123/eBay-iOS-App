//
//  ProfileViewController.swift
//  eBay
//
//  Created by Dan Hozan on 01.03.2024.
//

import UIKit
import ProgressHUD

class ProfileController: UIViewController {

    // MARK: - Properties
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if FirebaseAuthManager.shared.checkIfUserIsSignedIn() {
            configureSignOutButton()
        }
    }
    
    
    // MARK: - Confgurations
    private func configureSignOutButton() {
        let signOut = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = signOut
        
    }
    
    // MARK: - Actions
    @objc func signOut() {
        FirebaseAuthManager.shared.signOut { error in
            if let error = error {
                ProgressHUD.failed(error.localizedDescription)
                return
            }
            
            ProgressHUD.succeed("Sing Out")
            let destinationViewController = MainTabBarController()
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = destinationViewController
                
            }
        }
    }

    
}
