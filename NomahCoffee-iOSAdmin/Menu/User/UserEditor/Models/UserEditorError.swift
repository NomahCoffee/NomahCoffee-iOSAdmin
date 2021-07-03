//
//  UserEditorError.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import Foundation

enum UserEditorError {
    
    case missingEmail
    case missingUsername
    case missingFirstName
    case missingLastName
    case missingPassword
    case missingRepassword
    case missingPhoneNumber
    case generic
    
    /// Title of the error to be shown in a modal
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
        case .generic:
            return "Something went wrong"
        }
    }
    
    /// Message of the error to be shown in a modal
    var errorMessage: String? {
        switch self {
        case .missingEmail, .missingUsername, .missingFirstName, .missingLastName,
             .missingPassword, .missingRepassword, .missingPhoneNumber:
            return nil
        case .generic:
            return "Make sure all fields are entered correctly"
        }
    }
    
}
