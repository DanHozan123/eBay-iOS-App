//
//  ProfileViewController.swift
//  eBay
//
//  Created by Dan Hozan on 01.03.2024.
//

import UIKit
import ProgressHUD
import SDWebImage

class ProfileController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: ProfileViewModel? {
        didSet { configureUI() }
    }
    
    private lazy var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Username"
        return label
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signOuButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviewsConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = UserService.shared.getCurrentUserFromLocalMemory() {
            viewModel = ProfileViewModel(user: user)
        }
        else {
            goToMainTabBar()
        }
    }
    
    
    // MARK: - Confgurations
    
    private func configureUI() {
        guard let username = viewModel?.username else { return }
        guard let avatarLink = viewModel?.avatarLink else { return }

        usernameLabel.text = username
        
        let imageDefault = UIImageView()
        imageDefault.sd_setImage(with: URL(string: avatarLink)) { (_, error, _, _)  in
            if let error = error {
                print("ERROR: ", error.localizedDescription)
                return
            }
            self.profileImageView.image = imageDefault.image?.circleMasked
        }
   
    }
    
    private func addSubviewsConstraints() {
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10)
        profileImageView.setDimensions(height: 60, width: 60)
        
        
        view.addSubview(usernameLabel)
        usernameLabel.centerY(inView: profileImageView)
        usernameLabel.anchor(left: profileImageView.rightAnchor, paddingLeft: 10)
        
        view.addSubview(signOutButton)
        signOutButton.centerY(inView: profileImageView)
        signOutButton.anchor(right: view.rightAnchor , paddingRight: 10)
        signOutButton.setDimensions(height: 25, width: 100)
        
    }
    
    // MARK: - Actions
    
    @objc func signOuButtonPressed() {
        FirebaseAuthManager.shared.signOut { error in
            if let error = error {
                ProgressHUD.failed(error.localizedDescription)
                return
            }
            ProgressHUD.succeed("Sing Out")
            self.goToMainTabBar()
        }
    }
    
    
    //MARK: - Navigation
    
    private func goToMainTabBar(){
        let signInNC = UINavigationController(rootViewController: SignInController())
        signInNC.modalPresentationStyle = .fullScreen
        present(signInNC, animated: true, completion: nil)
    }
    
}
