//
//  Categories.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import UIKit

struct Category {
    let title: String
    let imagePath: String
    let color: UIColor
}

let Categories : [Category] = [Category(title: "Automobiles & Motorcycles", imagePath: "Automobiles & Motorcycles", color: .systemPink),
                               Category(title: "Books", imagePath: "Books", color: .systemMint),
                               Category(title: "Cell Phones & Accessories", imagePath: "Cell Phones & Accessories", color: .systemRed),
                               Category(title: "Computers & IT Accessories", imagePath: "Computers & IT Accessories", color: .systemYellow),
                               Category(title: "Hand Watches", imagePath: "Hand Watches", color: .systemCyan),
                               Category(title: "Jewellery", imagePath: "Jewellery", color: .systemBrown),
                               Category(title: "Medicine", imagePath: "Medicine", color: .systemOrange),
                               Category(title: "Furniture", imagePath: "Furniture", color: .systemBlue),
                               Category(title: "Men's Clothing & Accessory", imagePath: "Men's Clothing & Accessory", color: .systemGreen),
                               Category(title: "Tableware & Kitchenware", imagePath: "Tableware & Kitchenware", color: .systemPink),
                               Category(title: "Video Games & Consoles", imagePath: "Video Games & Consoles", color: .systemMint),
                               Category(title: "Women's Clothing & Accessory", imagePath: "Women's Clothing & Accessory", color: .systemRed)]
