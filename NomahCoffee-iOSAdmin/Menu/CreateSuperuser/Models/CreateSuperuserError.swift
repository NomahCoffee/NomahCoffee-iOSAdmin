//
//  CreateSuperuserError.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import Foundation

enum CreateSuperuserError {
    
    case missingEmail
    case missingUsername
    case missingFirstName
    case missingLastName
    case missingPassword
    case missingRepassword
    case missingPhoneNumber
    
    var errorTitle: String {
        switch self {
        case .missingEmail:
            return "Missing email"
        case .missingUsername:
            return "Missing username"
        case .missingFirstName:
            return "Missing first name"
        case .missingLastName:
            return "Missing last name"
        case .missingPassword:
            return "Missing password"
        case .missingRepassword:
            return "Missing password"
        case .missingPhoneNumber:
            return "Missing phone number"
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .missingEmail, .missingUsername, .missingFirstName, .missingLastName,
             .missingPassword, .missingRepassword, .missingPhoneNumber:
            return nil
        }
    }
    
}
