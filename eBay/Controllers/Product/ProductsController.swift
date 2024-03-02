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
    
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
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

    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableCell
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(ProductController(), animated: true)
    }
    
    

  
}
