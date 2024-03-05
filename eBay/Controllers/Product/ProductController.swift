//
//  ViewController.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit

class ProductController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Configurations
    private func configureUI(){
        navigationController?.navigationBar.tintColor = .systemPink
        view.backgroundColor = .white
    }

}
