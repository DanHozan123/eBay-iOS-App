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
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        fetchProducts()
    }
    
    // MARK: - Configurations
    
    private func configureUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        title = "Products"
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
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ProductController(), animated: true)
        
    }
    
}






