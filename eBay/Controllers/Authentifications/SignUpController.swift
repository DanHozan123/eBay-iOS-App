//
//  SignUpController.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit
import ProgressHUD

class SignUpController: UIViewController {
    
    
    // MARK: - Properties
    private var addProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDismissButton()
        addSubviewsConstraints()
    }
    
    
    // MARK: - Configurations
    private func configureUI() {
        navigationController?.navigationBar.tintColor = .black
        title = "Sign Up"
        view.backgroundColor = .white
    }
    
    private func configureDismissButton(){
        let dismissButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = dismissButton
    }
    
    private func addSubviewsConstraints() {
        view.addSubview(addProfileImageView)
        addProfileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        addProfileImageView.centerX(inView: view)
        addProfileImageView.setDimensions(height: 150, width: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        
        view.addSubview(stack)
        stack.anchor(top: addProfileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 50, paddingRight: 50, height: 40 + 15 + 40 + 15 + 40 + 15 + 40)

    }

    // MARK: - Actions
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
        let destinationViewController = MainTabBarController()

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = destinationViewController
        }
    }
    
    @objc private func signUpButtonPressed(){
        FirebaseAuthManager.shared.signUp(email: emailTextField.text!, password: passwordTextField.text!) { result in
            switch result{
            case .success(_):
                self.dismissView()
            case .failure(let error):
                ProgressHUD.failed(error.localizedDescription)
            }
        }
    }
    
    
}
