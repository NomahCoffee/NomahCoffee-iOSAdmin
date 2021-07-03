//
//  ProductEditorError.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 7/3/21.
//

import Foundation

enum ProductEditorError {
    
    case productIDDoesNotExist
    case generic
    
    /// Title of the error to be shown in a modal
    var errorTitle: String {
        switch self {
        case .productIDDoesNotExist:
            return "Product ID does not exist"
        case .generic:
            return "Something went wrong"
        }
    }
    
    /// Message of the error to be shown in a modal
    var errorMessage: String? {
        switch self {
        case .productIDDoesNotExist:
            return nil
        case .generic:
            return "Make sure all fields are entered correctly"
        }
    }
    
}
