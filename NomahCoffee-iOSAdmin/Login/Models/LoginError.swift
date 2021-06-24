//
//  LoginError.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import Foundation

enum LoginError {
    
    case missingEmail
    case missingPassword
    case generic
    
    /// Title of the error to be shown in a modal
    var errorTitle: String {
        switch self {
        case .missingEmail:
            return "Missing email"
        case .missingPassword:
            return "Missing password"
        case .generic:
            return "Something went wrong"
        }
    }
    
    /// Message of the error to be shown in a modal
    var errorMessage: String? {
        switch self {
        case .missingEmail, .missingPassword:
            return nil
        case .generic:
            return "Make sure your email is complete and your password is at least 8 characters long"
        }
    }
    
}
