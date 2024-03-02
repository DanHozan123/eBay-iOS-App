//
//  SignInViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 02.03.2024.
//

import Foundation

struct SingInViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
}
