//
//  ProductViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 05.03.2024.
//

import Foundation
import UIKit

struct ProductViewModel {
    
    private let product: Product
    
    var isAddToFavorites = false
    
    var urlImageProduct: String {
        return product.productImageLink
    }
    
    var titleProduct: String {
        return product.title
    }
    
    var subtitleProduct: String {
        return product.subtitle
    }
    
    var priceProduct: Double {
        return product.price
    }
    
    var descriptionPorduct: String {
        return product.description
    }
    
    var productId: String {
        return product.id
    }
    
    init(product: Product) {
        self.product = product
    }
    
    var getImage: UIImage {
        return isAddToFavorites == true ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
    }
    
}
