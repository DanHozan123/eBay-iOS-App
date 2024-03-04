//
//  ProfileViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//

import Foundation

struct ProfileViewModel {
    
    var user: User
      
    var username: String {
        return user.username
    }
    
    var avatarLink: String {
        return user.avatarLink
    }
    
}
