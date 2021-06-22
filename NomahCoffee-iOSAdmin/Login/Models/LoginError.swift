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
    
    var errorTitle: String {
        switch self {
        case .missingEmail:
            return "Missing email"
        case .missingPassword:
            return "Missing password"
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .missingEmail, .missingPassword:
            return nil
        }
    }
    
}
