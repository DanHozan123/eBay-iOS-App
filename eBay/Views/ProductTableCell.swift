//
//  ProductTableViewCell.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit

class ProductTableCell: UITableViewCell {

    // MARK: - Properties
    var viewModel: ProductViewModel? {
        didSet { configureSubviewCellUI() }
    }
    
    private var productImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let titleProductLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let subtitleProductLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor.systemGray
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
   
    private lazy var addFavoritesButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(addBasketButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    
    // MARK: - View LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
        addSubviewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func configureCellUI(){
        selectionStyle = .none
    }
    
    private func addSubviewsConstraints() {
        contentView.addSubview(productImageView)
        productImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor)
        productImageView.setDimensions(height: 150, width: 150)
        
        contentView.addSubview(titleProductLabel)
        titleProductLabel.anchor(top: topAnchor, left: productImageView.rightAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 5)
        
        contentView.addSubview(subtitleProductLabel)
        subtitleProductLabel.anchor(top: titleProductLabel.bottomAnchor, left: productImageView.rightAnchor, paddingTop: 5, paddingLeft: 10)
        
        contentView.addSubview(priceLabel)
        priceLabel.anchor(left: productImageView.rightAnchor, bottom: bottomAnchor, paddingLeft: 10, paddingBottom: 5)
        
        contentView.addSubview(addFavoritesButton)
        addFavoritesButton.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 10, paddingRight: 10)
        addFavoritesButton.setDimensions(height: 50, width: 50)
        
    }
    
    private func configureSubviewCellUI() {
        guard let viewModel = viewModel else { return }
        productImageView.sd_setImage(with: URL(string: viewModel.urlImageProduct))
        titleProductLabel.text = viewModel.titleProduct
        subtitleProductLabel.text = viewModel.subtitleProduct
        priceLabel.text = String(viewModel.priceProduct)
    }
    
    // MARK: - Actions
    
    @objc func addBasketButtonTapped(){
        print("DEBUG: addBasketButtonTapped()")
    }
    
    
    

}
