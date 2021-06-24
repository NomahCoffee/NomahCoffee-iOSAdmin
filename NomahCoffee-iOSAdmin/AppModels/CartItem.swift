//
//  CartItem.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import Foundation

struct CartItem: Codable {
    
    var id: Int
    var quantity: Int
    var coffee: Coffee
    
}
