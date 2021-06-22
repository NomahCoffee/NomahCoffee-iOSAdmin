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
    
    
    static func login(with email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        AF.request(
            "\(domain)/auth/token/login/",
            method: .post,
            parameters: ["email": email,
                         "password": password]
        ).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                
        
                if json["auth_token"].exists() {
                    completion(json["auth_token"].stringValue, nil)
                } else {
                    completion(nil, NSError(domain: "Unable to log in with provided credentials.", code: 0, userInfo: nil))
                }
            case .failure(let error):
                // TODO: Throw error message, could not connect to server
                completion(nil, error)
            }
        }
    }
    
    static func logout(completion: @escaping (Error?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(NSError(domain: "", code: 0, userInfo: [:]))
            return
        }
        
        AF.request(
            "\(domain)/auth/token/logout/",
            method: .post,
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
        
    static func createSuperuser(with email: String, username: String, firstName: String, lastName: String, password: String,
                                repassword: String, phoneNumber: String, completion: @escaping (Error?) -> Void) {
        guard let authToken = UserDefaults().string(forKey: "authToken") else {
            completion(NSError(domain: "", code: 0, userInfo: [:]))
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
                         "phone": phoneNumber],
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
            completion(nil)//, NSError(domain: "", code: 0, userInfo: [:]))
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
                    for user in allUsers.results {
                        print(user.username)
                    }
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
                    for user in allUsers.results {
                        print(user.username)
                    }
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
                    for user in allUsers.results {
                        print(user.username)
                    }
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
                    for coffee in allCoffee.results {
                        print(coffee.name)
                    }
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
    
    static func getGear(completion: @escaping () -> Void) {
        guard let url = Bundle.main.path(forResource: "gear", ofType: "json") else { return }
        
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                let json = JSON(data)
                
                completion()
            case .failure(let error):
                //Do something with error
                completion()
            }
        }
    }
    
}

struct Gear {
    
}
