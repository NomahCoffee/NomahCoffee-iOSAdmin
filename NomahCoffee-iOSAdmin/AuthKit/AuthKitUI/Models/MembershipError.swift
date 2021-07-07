//
//  MembershipError.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import Foundation

enum MembershipError {
    
    case generic
    
    /// Title of the error to be shown in a modal
    var title: String {
        switch self {
        case .generic:
            return "Something went wrong"
        }
    }
    
    /// Message of the error to be shown in a modal
    var message: String? {
        switch self {
        case .generic:
            return "Make sure your email is complete and your password is at least 8 characters long"
        }
    }
    
}
