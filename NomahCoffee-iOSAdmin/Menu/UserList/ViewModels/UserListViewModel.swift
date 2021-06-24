//
//  UserListViewModel.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/23/21.
//

import Foundation

class UserListViewModel {
    
    // MARK: Properties
    
    let users: [User]
    
    // MARK: Init
    
    init(users: [User]) {
        self.users = users
    }
    
}
