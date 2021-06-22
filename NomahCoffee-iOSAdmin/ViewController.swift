//
//  ViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/25/21.
//

import UIKit
import SnapKit

final class ViewController: UIViewController, MenuViewDelegate {
    
    
//    let menuTableViewController: MenuTableTableViewController = {
//        let menuOptions = [
//            MenuOption(title: "Create superuser", endpoint: "createUser endpoint", detailController: CreateSuperUserViewController()),
//            MenuOption(title: "Edit your superuser details", endpoint: "editYourDetails endpoint", detailController: CreateSuperUserViewController())
//        ]
//        let menuTableViewModel = MenuTableViewModel(menuOptions: menuOptions)
//        let menuTableViewController = MenuTableTableViewController(viewModel: menuTableViewModel)
//        return menuTableViewController
//    }()
    
    lazy var menuView: MenuView = {
        let menuOptions = [
            MenuOption(title: "Create superuser", endpoint: "createUser endpoint", detailController: CreateSuperUserViewController()),
            MenuOption(title: "Edit your superuser details", endpoint: "editYourDetails endpoint", detailController: CreateSuperUserViewController())
        ]
        let menuTableViewModel = MenuTableViewModel(menuOptions: menuOptions)
        let menuView = MenuView(viewModel: menuTableViewModel)
        menuView.delegate = self
        return menuView
    }()
    
    let logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.backgroundColor = .systemRed
        return logoutButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        view.addSubview(menuView)
        view.addSubview(logoutButton)
        
        menuView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(logoutButton.snp.top)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(64)
        }
    }
    
    @objc func logoutButtonTapped() {
        NetworkingManager().logout { error in
            if error != nil {
                // Present error to user
                print(error?.localizedDescription)
            }
            
            UserDefaults().removeObject(forKey: "authToken")
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    func present(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

