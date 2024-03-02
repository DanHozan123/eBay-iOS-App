//
//  File.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit

class SignInController: UIViewController {
    
    // MARK: - Properties
    private var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "eBay")
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviewsConstraints()
    }
    
    // MARK: - Configurations
    private func configureUI(){
        navigationController?.navigationBar.tintColor = .black
        title = "Add Product"
        view.backgroundColor = .white
    }
    
    
    private func addSubviewsConstraints() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: view.frame.width)
    }
  

}
