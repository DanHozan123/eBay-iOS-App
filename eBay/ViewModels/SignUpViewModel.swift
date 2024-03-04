//
//  SignUpViewModel.swift
//  eBay
//
//  Created by Dan Hozan on 03.03.2024.
//

import UIKit

struct SignUpViewModel {
    
    var email: String?
    var username: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonColor: UIColor {
        return formIsValid ? .blue : .systemGray5
    }
    
}
