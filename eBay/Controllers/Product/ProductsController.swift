//
//  ProductsTableViewController.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductsController: UITableViewController {
    
    // MARK: - Properties
    private var products = [Product]() {
        didSet { tableView.reloadData() }
    }
    
    private var currentUserId: String?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        fetchProducts()
    }
    
    // MARK: - Configurations
    
    private func configure(){
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        title = "Products"
        var currentUser = UserService.shared.getCurrentUserIdFromLocalMemory()
        if currentUser != "" {
            self.currentUserId = currentUser
        }
        
    }
    
    private func configureTableView(){
        tableView.register(ProductTableCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Helpers
    
    private func fetchProducts() {
        ProductService.shared.fetchProducts { products in
            guard let products = products else { return }
            self.products = products
        }
    }

    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableCell
        
        cell.viewModel = ProductViewModel(product: products[indexPath.row])
        cell.delegate = self
    

        if let currentUserId = self.currentUserId {
            ProductService.shared.checkIfProductIsOnUserFavoritesList(productId: products[indexPath.row].id, userId: currentUserId){ exists in
                if exists {
                    cell.viewModel?.isAddToFavorites = true
                }
            }
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productVC = ProductController()
        productVC.viewModel = ProductDetailViewModel(product: products[indexPath.row])
        navigationController?.pushViewController(productVC, animated: true)
        
    }
    
}
// MARK: - ProductTableCellDelegate
extension ProductsController: ProductTableCellDelegate {
    func cellWantsToBeRemovedFromFavoritesList(cell: ProductTableCell) {
        guard let currentUserId = currentUserId else { return }
        print("DEBUG: remove")
        ProductService.shared.deleteProductFromFavoritesList(productId: cell.viewModel!.productId, userId: currentUserId) { error in
            if let error = error {
                print("ERROR:", error.localizedDescription)
            } else {
                cell.addFavoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.viewModel?.isAddToFavorites = false
            }
        }
        
    }
    
    func cellWantsToBeAddedToFavoritesList(cell: ProductTableCell) {
        guard let currentUserId = currentUserId else { return }
        print("DEBUG: add")
        ProductService.shared.addToFavoritesListProduct(thisProduct: cell.viewModel!.productId, toThisUserFavoritesList: currentUserId) { error in
            
            if let error = error {
                print("ERROR:", error.localizedDescription)
            } else {
                cell.addFavoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.viewModel?.isAddToFavorites = true
            }
        }
    }
  
}


