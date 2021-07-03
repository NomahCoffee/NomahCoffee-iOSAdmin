//
//  ProductEditorActionType.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 7/2/21.
//

import Foundation

enum ProductEditorActionType {
    
    case create
    case edit
    
    /// The navigation bar title
    var navigationTitle: String {
        switch self {
        case .create: return "Create Coffee"
        case .edit: return "Edit Coffee"
        }
    }
    
    /// The CTA button title
    var ctaButtonTitle: String {
        switch self {
        case .create: return "Create"
        case .edit: return "Edit"
        }
    }
    
}
