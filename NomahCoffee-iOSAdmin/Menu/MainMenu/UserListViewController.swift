//
//  UserListViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 5/11/21.
//

import UIKit

public enum UserType {
    case all
    case superuser
    case staff
    case coffee
}

class UserListViewController: UIViewController {
    
    private var userType: UserType

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        switch userType {
//        case .all:
//            NetworkingManager.getAllUsers(completion: { users in
//                guard let users = users else { return }
//                print(users)
//            })
//        case .superuser:
//            NetworkingManager.getAllSuperusers(completion: { users in
//                guard let users = users else { return }
//                print(users)
//            })
//        case .staff:
//            NetworkingManager.getAllStaff(completion: { users in
//                guard let users = users else { return }
//                print(users)
//            })
//        case .coffee:
//            NetworkingManager.getCoffee(completion: { coffees in
//                guard let coffees = coffees else { return }
//                print(coffees)
//            })
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        case .coffee:
            NetworkingManager.getCoffee(completion: { coffees in
                guard let coffees = coffees else { return }
                print(coffees)
            })
        }
    }
    
    init(userType: UserType) {
        self.userType = userType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
