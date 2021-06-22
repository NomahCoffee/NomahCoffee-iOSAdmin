//
//  LoginViewModel.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import Foundation

class LoginViewModel {
        
    // MARK: Init
    
    init() {}
    
    // MARK: Properties
    
    var titleLabelTitle: String {
        return "Nomah Coffee Admin"
    }
    
    var emailTextFieldPlaceholder: String {
       return "Email"
    }

    var passwordTextFieldPlaceholder: String {
        return "Password"
    }
    
    var loginButtonTitle: String {
        return "Login"
    }
    
}
