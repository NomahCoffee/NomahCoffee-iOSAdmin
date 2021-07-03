//
//  UserEditorActionType.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import Foundation

enum UserEditorActionType: Equatable {
    
    case create
    case editMe
    case editOther(user: User)
    
    /// The navigation bar title
    var navigationTitle: String {
        switch self {
        case .create: return "Create Superuser"
        case .editMe: return "Edit My User"
        case .editOther: return "Edit Other User"
        }
    }
    
    /// The CTA button title
    var ctaButtonTitle: String {
        switch self {
        case .create: return "Create"
        case .editMe: return "Edit"
        case .editOther: return "Not available"
        }
    }
    
    static func == (lhs: UserEditorActionType, rhs: UserEditorActionType) -> Bool {
        switch (lhs, rhs) {
        case (.create, .create), (.editMe, .editMe), (.editOther(_), .editOther(_)):
            return true
        default:
            return false
        }
    }
    
}
