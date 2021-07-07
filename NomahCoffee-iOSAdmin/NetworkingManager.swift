//
//  NetworkingManager.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/26/21.
//

import Foundation
import Alamofire
import SwiftyJSON

public class NetworkingManager {
    
    // MARK: Private Properties
    
    private static var domain: String {
        #if DEBUG
            return "http://127.0.0.1:8000"
        #endif
    }
    
    // MARK: Private Functions
    
    private static func getHeaders(with authToken: String) -> HTTPHeaders {
        let headers = HTTPHeaders([
            HTTPHeader(name: "Authorization", value: "Token \(authToken)"),
            HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded")
        ])
        return headers
    }
    
    // MARK: Static Functions
    
    /// Get the information of the current superuser logged into the admin app
    /// - Parameter completion: a completion of type `User?` which will send back the user object in
    /// in the case of a successful request and `nil` in the case of a failure
    static func getMyUser(completion: @escaping (User?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(nil)
            return
        }
        
        AF.request(
            "\(domain)/auth/users/me/",
            method: .get,
            headers: getHeaders(with: authToken)
        ).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(user)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    static func editSuperuser(with email: String, username: String, firstName: String,
                              lastName: String, completion: @escaping (Error?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(NSError(domain: "Unable to find an auth token", code: 0, userInfo: nil))
            return
        }
        
        AF.request(
            "\(domain)/auth/users/me/",
            method: .put,
            parameters: ["username": username,
                         "first_name": firstName,
                         "last_name": lastName,
                         "email": email,
                         "is_superuser": true,
                         "is_staff": true],
            headers: getHeaders(with: authToken)
        ).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                completion(nil)
//                let json = JSON(data)
//                guard let data = response.data else { return }
//
//                do {
//                    let user = try JSONDecoder().decode(CurrentUser.self, from: data)
////                    let allUsers = try JSONDecoder().decode(UserList.self, from: data)
////                    for user in allUsers.results {
////                        print(user.username)
////                    }
//                    completion(user)
            case .failure(let error):
                completion(error) //TODO completion with error
            }
        }
    }
        
    static func createSuperuser(with email: String, username: String, firstName: String, lastName: String, password: String,
                                repassword: String, completion: @escaping (Error?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(NSError(domain: "Unable to find an auth token", code: 0, userInfo: nil))
            return
        }
        
        AF.request(
            "\(domain)/auth/users/",
            method: .post,
            parameters: ["email": email,
                         "username": username,
                         "first_name": firstName,
                         "last_name": lastName,
                         "password": password,
                         "re_password": repassword,
                         "is_superuser": true,
                         "is_staff": true],
            headers: getHeaders(with: authToken)
        ).responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func getAllUsers(completion: @escaping ([User]?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(nil)
            return
        }
        
        AF.request(
            "\(domain)/auth/users/",
            method: .get,
            headers: getHeaders(with: authToken)
        ).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                guard let data = response.data else { return }
                
                do {
                    let allUsers = try JSONDecoder().decode(UserList.self, from: data)
//                    for user in allUsers.results {
//                        print(user.username)
//                    }
                    completion(allUsers.results)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            case .failure(let error):
                completion(nil)
            }
        }
    }
    
    static func getAllSuperusers(completion: @escaping ([User]?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(nil)//, NSError(domain: "", code: 0, userInfo: [:]))
            return
        }
        
        AF.request(
            "\(domain)/auth/superusers/",
            method: .get,
            headers: getHeaders(with: authToken)
        ).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                guard let data = response.data else { return }
                
                do {
                    let allUsers = try JSONDecoder().decode(UserList.self, from: data)
//                    for user in allUsers.results {
//                        print(user.username)
//                    }
                    completion(allUsers.results)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            case .failure(let error):
                completion(nil) //TODO completion with error
            }
        }
    }
    
    static func getAllStaff(completion: @escaping ([User]?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(nil)//, NSError(domain: "", code: 0, userInfo: [:]))
            return
        }
        
        AF.request(
            "\(domain)/auth/staff/",
            method: .get,
            headers: getHeaders(with: authToken)
        ).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                guard let data = response.data else { return }
                
                do {
                    let allUsers = try JSONDecoder().decode(UserList.self, from: data)
//                    for user in allUsers.results {
//                        print(user.username)
//                    }
                    completion(allUsers.results)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            case .failure(let error):
                completion(nil) //TODO completion with error
            }
        }
    }
    
    static func getCoffee(completion: @escaping ([Coffee]?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(nil)//, NSError(domain: "", code: 0, userInfo: [:]))
            return
        }
        
        AF.request(
            "\(domain)/api/coffee/",
            method: .get
        ).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                guard let data = response.data else { return }
                
                do {
                    let allCoffee = try JSONDecoder().decode(CoffeeList.self, from: data)
//                    for coffee in allCoffee.results {
//                        print(coffee.name)
//                    }
                    completion(allCoffee.results)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            case .failure(let error):
                completion(nil) //TODO completion with error
            }
        }
    }
    
    /// Create a brand new coffee object
    /// - Parameters:
    ///   - name: the `String` value for the name of the coffee
    ///   - price: the `Double` value representing the price of the coffee
    ///   - description: the `String` value detailing a description of the coffee
    ///   - inStock: the `Bool` value as to whether or not the coffee is in stock
    ///   - completion: a completion of type `Error?` which will send back an error in the case
    ///   of a failure or `nil` in the case of a successful coffee creation.
    static func createCoffee(name: String, price: Double, description: String, inStock: Bool, completion: @escaping (Error?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(NSError(domain: "Unable to find an auth token", code: 0, userInfo: nil))
            return
        }
        
        AF.request(
            "\(domain)/api/coffee/",
            method: .post,
            parameters: ["name": name,
                         "price": price,
                         "description": description,
                         "in_stock": inStock],
            headers: getHeaders(with: authToken)
            ).responseJSON { response in
                switch response.result {
                case .success(_):
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
    }
    
    /// Edit an existing coffee object
    /// - Parameters:
    ///   - id: the `String` representation of the coffee's id
    ///   - name: a `String` for the updated name of the coffee
    ///   - price: a `Double` for the updated price of the coffee
    ///   - description: a `String` for the updated description of the coffee
    ///   - inStock: a `Bool` for the updated status of whether or not the coffee is in stock
    ///   - completion: a completion of type `Error?` which will send back an error in the case
    ///   of a failure or `nil` in the case of a successful coffee edit.
    static func editCoffee(id: Int, name: String, price: Double, description: String, inStock: Bool, completion: @escaping (Error?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(NSError(domain: "Unable to find an auth token", code: 0, userInfo: nil))
            return
        }
        
        AF.request(
            "\(domain)/api/coffee/\(id)/",
            method: .put,
            parameters: ["name": name,
                         "price": price,
                         "description": description,
                         "in_stock": inStock],
            headers: getHeaders(with: authToken)
            ).responseJSON { response in
                switch response.result {
                case .success(_):
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
    }
    
}
