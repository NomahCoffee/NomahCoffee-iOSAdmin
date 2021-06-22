//
//  CreateSuperuserViewModel.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import Foundation

class CreateSuperuserViewModel {
    
    // MARK: Init
    
    init() {}
    
    // MARK: Properties
    
    var emailTextFieldPlaceholder: String {
       return "Email"
    }
    
    var usernameTextFieldPlaceholder: String {
        return "Username"
    }
    
    var firstNameTextFieldPlaceholder: String {
       return "First name"
    }
    
    var lastNameTextFieldPlaceholder: String {
        return "Last Name"
    }

    var passwordTextFieldPlaceholder: String {
        return "Password"
    }
    
    var repasswordTextFieldPlaceholder: String {
        return "Password (again)"
    }
    
    var phoneNumberTextFieldPlaceholder: String {
        return "Phone Number"
    }
    
    var createSuperuserButtonTitle: String {
        return "Create"
    }
    
}
