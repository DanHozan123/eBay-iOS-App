//
//  File.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit
import ProgressHUD

class SignInController: UIViewController {
    
    
    // MARK: - Properties
    
    private var viewModel = SingInViewModel()
    
    private var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ebay logo")
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
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.systemGray5
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have and account? Sign Up!", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()


    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDismissButton()
        configureNotificationObservers()
        addSubviewsConstraints()
    }
    
    // MARK: - Configurations
    private func configureUI(){
        navigationController?.navigationBar.tintColor = .black
        title = "Sign In"
        view.backgroundColor = .white
    }
    
    private func configureDismissButton(){
        let dismissButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = dismissButton
    }
    
    private func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    private func addSubviewsConstraints() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        logoImageView.centerX(inView: view)
        logoImageView.setDimensions(height: 150, width: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton])
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 50, paddingRight: 50, height: 40 + 15 + 40 + 15 + 40)
        
        view.addSubview(signUpButton)
        signUpButton.centerX(inView: view)
        signUpButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
        
    }
    
    // MARK: - Actions
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
        let destinationViewController = MainTabBarController()

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = destinationViewController
        }
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = emailTextField.text
        }
        else if sender == passwordTextField {
            viewModel.password = passwordTextField.text
        }
        updateForm()
        
    }
    
    @objc private func signInButtonPressed(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        FirebaseAuthManager.shared.signIn(email: email, password: password) { error in
            if let error = error {
                ProgressHUD.failed("\(error.localizedDescription)")
                return
                
            }
            self.dismissView()
        }
    }
    
    
    @objc private func signUpButtonPressed(){
        navigationController?.pushViewController(SignUpController(), animated: true)

    }
    
    // MARK: - Helpers
    
    private func updateForm(){
        signInButton.isEnabled = viewModel.formIsValid
        signInButton.backgroundColor = viewModel.buttonColor

    }
    
    
}
