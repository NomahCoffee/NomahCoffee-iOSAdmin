//
//  ProductListViewModel.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import Foundation

class ProductListViewModel {
    
    // MARK: Properties
    
    let coffees: [Coffee]
    
    // MARK: Init
    
    init(coffees: [Coffee]) {
        self.coffees = coffees
    }
    
}
