//
//  Product.swift
//  eBay
//
//  Created by Dan Hozan on 05.03.2024.
//

import Foundation

struct Product: Codable {
    let id: String
    let ownerId: String
    let title: String
    let subtitile: String
    let price: Double
    let description: String
    let productImageLink: String
    let timestamp: Date
    
    init(id: String, ownerId: String, title: String, subtitile: String, price: Double, description: String, productImageLink: String, timestamp: Date) {
        self.id = id
        self.ownerId = ownerId
        self.title = title
        self.subtitile = subtitile
        self.price = price
        self.description = description
        self.productImageLink = productImageLink
        self.timestamp = timestamp
    }
}
