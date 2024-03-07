//
//  ProductDetailViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 06.03.2024.
//

import Foundation

struct ProductDetailViewModel {
    
    private let product: Product
    
    var productId: String {
        return product.id
    }

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
    
    var productOwnerId: String {
        return product.ownerId
    }

    init(product: Product) {
        self.product = product
    }
    

    
    
}
