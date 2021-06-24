//
//  UserType.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import Foundation

enum UserType {
    
    case all
    case superuser
    case staff
    
    /// The navigation bar title
    var navigationTitle: String {
        switch self {
        case .all: return "All Users"
        case .superuser: return "All Supersers"
        case .staff: return "All Staff"
        }
    }
    
}
