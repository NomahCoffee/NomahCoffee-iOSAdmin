//
//  AllUsersViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 5/9/21.
//

import UIKit

//public enum UserType {
//    case all
//    case superuser
//    case staff
//}

class AllUsersViewController: UIViewController {
    
    public var userType: UserType

    override func viewDidLoad() {
        super.viewDidLoad()

        switch userType {
        case .all:
            NetworkingManager.getAllUsers(completion: { users in
                guard let users = users else { return }
                print(users)
            })
        case .superuser:
            NetworkingManager.getAllSuperusers(completion: { users in
                guard let users = users else { return }
                print(users)
            })
        case .staff:
            NetworkingManager.getAllStaff(completion: { users in
                guard let users = users else { return }
                print(users)
            })
        }
//        NetworkingManager.getAllUsers(completion: { users in
////            if error != nil {
////                print(error?.localizedDescription)
////            }
//            guard let users = users else { return }
//            print(users)
////            for user in users {
////                print(user.username)
////            }
//        })
    }
    
    init(userType: UserType) {
        self.userType = userType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
