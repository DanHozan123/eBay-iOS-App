//
//  AddProductController.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit
import YPImagePicker
import ProgressHUD

class AddProductController: UIViewController {
    
    // MARK: - Properties
    
    private var picker: YPImagePicker?
    private var productSelectedImage : UIImage?
    private var user: User?
    
    private lazy var productImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add image")
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addProductImageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private let subtitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Subtitle"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Price"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 10
        // Set placeholder text
        textView.text = "Enter your description here"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.lightGray

        // Set up behavior for multiline input
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainer.maximumNumberOfLines = 0
        return textView
    }()
    
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarAndTitle()
        configureImagePicker()
        configureNBButton()
        addSubviewsConstraints()
    }
    
    // MARK: - Configurations
    
    private func configureNavBarAndTitle(){
        navigationController?.navigationBar.tintColor = .black
        title = "Add Product"
        view.backgroundColor = .white
    }
    
    private func configureImagePicker(){
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.startOnScreen = .library
        config.colors.tintColor = .black
        picker = YPImagePicker(configuration: config)
        
    }
    
    private func configureNBButton(){
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func addSubviewsConstraints() {
        view.addSubview(productImageView)
        productImageView.centerX(inView: view)
        productImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        productImageView.setDimensions(height: 250, width: 250)
        
        view.addSubview(titleTextField)
        titleTextField.anchor(top: productImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, height: 50)
      
        view.addSubview(subtitleTextField)
        subtitleTextField.anchor(top: titleTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, height: 50)
        
        view.addSubview(priceTextField)
        priceTextField.anchor(top: subtitleTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, height: 50)
        
         view.addSubview(descriptionTextView)
         descriptionTextView.anchor(top: priceTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15, height: 150)
    }
    
    // MARK: - Actions
    
    @objc private func addProductImageTapped() {
        guard let picker = picker else { return }
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.productImageView.image = photo.image
                self.productSelectedImage = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func rightButtonTapped() {
        if titleTextField.text != "" && subtitleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "" {
            if let image = productSelectedImage {
                let productData = ProductData(image: image, title: titleTextField.text!, subtitile: subtitleTextField.text!, price: priceTextField.text!, description: descriptionTextView.text!)
                ProductService.shared.uploadProduct(prodcutToUpload: productData)
                self.goToMainTabBar()
                
            } else {
                ProgressHUD.failed("Please set an image for your product")
            }

        } else {
            ProgressHUD.failed("Please fill all fields")
        }
    }
    
    
    // MARK: - Navigation
    
    private func goToMainTabBar(){
        let destinationViewController = MainTabBarController()
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = destinationViewController
        }
        
    }
    
}
