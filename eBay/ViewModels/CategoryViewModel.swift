//
//  CategoryViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit

struct CategoryViewModel {
    
    private let category: Category
    
    var title: String {
        return category.title
    }
    
    var image: UIImage? {
        return UIImage(named: category.imagePath)
    }
    
    var color: UIColor {
        return category.color
    }
    
    init(category: Category) {
        self.category = category
    }
    
}
