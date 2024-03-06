//
//  ProfileViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//

import Foundation

struct ProfileViewModel {
    
    private let user: User
      
    var username: String {
        return user.username
    }
    
    var avatarLink: String {
        return user.avatarLink
    }
    
    init(user: User) {
        self.user = user
    }
    
}
