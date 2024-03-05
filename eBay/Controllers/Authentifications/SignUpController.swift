//
//  SignUpController.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit
import ProgressHUD
import YPImagePicker


class SignUpController: UIViewController {
    
    
    // MARK: - Properties
    
    private var viewModel = SignUpViewModel()
    private var picker: YPImagePicker?
    
    private lazy var addProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addProfileImageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
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
        button.backgroundColor = UIColor.systemGray5
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDismissButton()
        configureNotificationObservers()
        configureImagePicker()
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
    
    private func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    private func configureImagePicker(){
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.startOnScreen = .library
        config.colors.tintColor = .black
        picker = YPImagePicker(configuration: config)
        
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
        let destinationViewController = MainTabBarController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = destinationViewController
        }
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = emailTextField.text
        }
        else if sender == usernameTextField {
            viewModel.username = usernameTextField.text
        }
        else if sender == passwordTextField {
            viewModel.password = passwordTextField.text
        }
        
        updateForm()
        
    }
    
    
    @objc private func signUpButtonPressed(){
        guard let email = viewModel.email else { return }
        guard let username = viewModel.username else { return }
        guard let password = viewModel.password else { return }

        
        FirebaseAuthManager.shared.signUp(email: email, username: username, password: password, avatarIamge: addProfileImageView.image) { error in
            if let error = error {
                ProgressHUD.failed(error.localizedDescription)
                return
            }
        
            ProgressHUD.succeed("Sign Up Completed")
            self.dismissView()
        }
    }
    
    @objc private func addProfileImageTapped() {
        guard let picker = picker else { return }
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                let imageDefault = UIImageView()
                imageDefault.image = photo.image
                self.addProfileImageView.image = imageDefault.image?.circleMasked
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Helpers
    
    private func updateForm(){
        signUpButton.isEnabled = viewModel.formIsValid
        signUpButton.backgroundColor = viewModel.buttonColor
        
    }

    
}
