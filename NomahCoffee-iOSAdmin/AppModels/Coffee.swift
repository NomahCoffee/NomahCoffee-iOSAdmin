//
//  Coffee.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import Foundation

public struct Coffee: Codable {
    
    var id: Int
    var created: String
    var name: String
    var price: Double
    var image: URL?
    var description: String
    var inStock: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case created
        case name
        case price
        case image
        case description
        case inStock = "in_stock"
    }
    
}
