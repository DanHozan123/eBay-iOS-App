//
//  ProductViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 05.03.2024.
//

import Foundation

struct ProductViewModel {
    
    private let product: Product
    
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
    
    init(product: Product) {
        self.product = product
    }
    
}
