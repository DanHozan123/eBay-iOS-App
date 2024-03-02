//
//  CategoriesViewController.swift
//  eBay
//
//  Created by Dan Hozan on 01.03.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesController: UICollectionViewController {

    // MARK: - Properties
    var categories: [Category] = Categories
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupAddProductButton()
        configureCollectionView()
    }
    
    
    // MARK: - Configurations
    
    func configureUI(){
        view.backgroundColor = .white
        title = "Categories"

    }
    
    private func setupAddProductButton(){
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductButtonTapped))
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button
    }
    
    func configureCollectionView(){
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10)
        
    }
    
    // MARK: - Actinos
    
    @objc private func addProductButtonTapped(){
        navigationController?.pushViewController(AddProductController(), animated: true)
    }
    
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionCell
        
        cell.viewModel = CategoryViewModel(category: Categories[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ProductsController(), animated: true)
    }
    
}

//MARK: - UICollectionViewDeleagteFlowLayout

extension CategoriesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 30 ) / 2
        return CGSize(width: width, height: width)
    }
}

