//
//  MenuViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import UIKit
import AuthKit

final class MenuViewController: UIViewController, MenuViewDelegate {
    
    // MARK: Properties

    private lazy var menuView: MenuView = {
        let menuOptions = [
            MenuOption(title: "Create superuser", detailController: UserEditorViewController(actionType: .create)),
            MenuOption(title: "Edit your superuser details", detailController: UserEditorViewController(actionType: .editMe)),
            MenuOption(title: "See all users", detailController: UserListViewController(userType: .all)),
            MenuOption(title: "See superusers", detailController: UserListViewController(userType: .superuser)),
            MenuOption(title: "See staff", detailController: UserListViewController(userType: .staff)),
            MenuOption(title: "See coffee", detailController: ProductListViewController(productType: .coffee))
        ]
        let menuTableViewModel = MenuTableViewModel(menuOptions: menuOptions)
        let menuView = MenuView(viewModel: menuTableViewModel)
        menuView.delegate = self
        return menuView
    }()
    
    private let logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.setTitle(MenuConstants.logoutButtonTitle, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.backgroundColor = .systemRed
        return logoutButton
    }()
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = MenuConstants.navigationBarTitle
                        
        view.addSubview(menuView)
        view.addSubview(logoutButton)
        
        menuView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(logoutButton.snp.top)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(MenuConstants.logoutButtonHeight)
        }
    }
    
    // MARK: Actions
    
    @objc func logoutButtonTapped() {
        AuthKitManager.shared.logout(from: self)
    }
    
    // MARK: MenuViewDelegate
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}
