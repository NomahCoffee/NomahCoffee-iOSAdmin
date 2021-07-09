//
//  AuthKitUser.swift
//  AuthKit
//
//  Created by Caleb Rudnicki on 7/7/21.
//

import Foundation

struct AuthKitUserList: Codable {
    let results: [AuthKitUser]
}

struct AuthKitUser: Codable {
    
    var id: Int
    var email: String
    var username: String
    var firstName: String
    var lastName: String
    var isSuperuser: Bool
    var isStaff: Bool
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        username = try values.decode(String.self, forKey: .username)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        isSuperuser = try values.decode(Bool.self, forKey: .isSuperuser)
        isStaff = try values.decode(Bool.self, forKey: .isStaff)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(username, forKey: .username)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(isSuperuser, forKey: .isSuperuser)
        try container.encode(isStaff, forKey: .isStaff)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case isSuperuser = "is_superuser"
        case isStaff = "is_staff"
    }
    
}
