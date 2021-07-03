//
//  ProductProtocol.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 7/2/21.
//

import Foundation

/// This protocol is used to communicate between subcomponents
/// dealing with product decisions and edits
protocol ProductProtocol {
    /// This triggers a list to be refreshed
    func refreshList()
}
