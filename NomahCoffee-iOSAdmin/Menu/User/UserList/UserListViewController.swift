//
//  UserListViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 5/11/21.
//

import UIKit
import SnapKit

class UserListViewController: UIViewController, UserListViewDelegate {
    
    // MARK: Properties

    private var userType: UserType
    
    private var userListViewModel: UserListViewModel?
    
    private lazy var userListView: UserListView = {
        let userListView = UserListView()
        userListView.delegate = self
        return userListView
    }()
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = userType.navigationTitle
        
        view.addSubview(userListView)
        
        userListView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        switch userType {
        case .all:
            NetworkingManager.getAllUsers(completion: { users in
                guard let users = users else { return }
                self.userListView.viewModel = UserListViewModel(users: users)
            })
        case .superuser:
            NetworkingManager.getAllSuperusers(completion: { users in
                guard let users = users else { return }
                self.userListView.viewModel = UserListViewModel(users: users)
            })
        case .staff:
            NetworkingManager.getAllStaff(completion: { users in
                guard let users = users else { return }
                self.userListView.viewModel = UserListViewModel(users: users)
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
    
    // MARK: UserListViewDelegate
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}
