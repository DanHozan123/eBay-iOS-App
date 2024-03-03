//
//  User.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//

import FirebaseAuth

struct User: Codable {
    
    var id = ""
    var email: String
    var username: String
    var avatarLink : String
    
    init(id: String, email: String, username: String, avatarLink: String = "") {
        self.id = id
        self.email = email
        self.username = username
        self.avatarLink = avatarLink
    }
    
}
