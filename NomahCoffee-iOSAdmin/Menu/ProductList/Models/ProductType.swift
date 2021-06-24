//
//  ProductType.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import Foundation

enum ProductType {
    
    case coffee
    
    /// The navigation bar title
    var navigationTitle: String {
        switch self {
        case .coffee: return "Coffee"
        }
    }
    
}
