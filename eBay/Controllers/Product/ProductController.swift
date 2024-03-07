//
//  ViewController.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit

class ProductController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ProductDetailViewModel? {
        didSet { configureSubViewsUI() }
    }
    
    let imageProductView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainer.maximumNumberOfLines = 0
        return textView
    }()
    
    
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCellUI()
        addSubviewsConstraints()
        
    }
    
    
    
    // MARK: - Configurations
    private func configureCellUI() {
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        title = "Product Detail"
    }
    
    private func configureSubViewsUI() {
        guard let viewModel = viewModel else { return }
        imageProductView.sd_setImage(with: URL(string: viewModel.urlImageProduct))
        titleLabel.text = viewModel.titleProduct
        subtitleLabel.text = viewModel.subtitleProduct
        priceLabel.text = String(viewModel.priceProduct)
        descriptionTextView.text = viewModel.descriptionPorduct
    }
    
    private func addSubviewsConstraints() {
        view.addSubview(imageProductView)
        imageProductView.centerX(inView: view)
        imageProductView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        imageProductView.setDimensions(height: 250, width: 250)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: imageProductView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingRight: 15, height: 50)
      
        view.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingRight: 15, height: 50)
        
        view.addSubview(priceLabel)
        priceLabel.anchor(top: subtitleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingRight: 15, height: 50)
        
         view.addSubview(descriptionTextView)
        descriptionTextView.anchor(top: priceLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingRight: 15, height: 150)
    }
    
    
}
