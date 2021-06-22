//
//  LoginViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/27/21.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, LoginViewDelegate {
    
    // MARK: Properties
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        loginView.viewModel = LoginViewModel()
        loginView.delegate = self
        return loginView
    }()
    
    // MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NetworkingManager.getGear(completion: {
            print("got gear")
        })
    }
    
//    @objc func loginButtonTapped() {
//        NetworkingManager().login(with: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: { authToken, error in
//            if error != nil {
//                // TODO: Present error to user
//                print(error?.localizedDescription)
//                return
//            }
//
//            UserDefaults().set(authToken, forKey: "authToken")
//            let navigationController = UINavigationController(rootViewController: MenuViewController())
//            navigationController.modalPresentationStyle = .fullScreen
//            self.present(navigationController, animated: true, completion: nil)
//        })
//    }
    
    // MARK: LoginViewDelegate
    
    func loginButtonTapped(email: String, password: String) {
        NetworkingManager.login(with: email, password: password, completion: { authToken, error in
            if error != nil {
                let alert = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loginView.clearTextFields()
                return
            }
            
            UserDefaults().set(authToken, forKey: "authToken")
            let navigationController = UINavigationController(rootViewController: MenuViewController())
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        })
    }
    
    func errorFound(_ error: LoginError) {
        let alert = UIAlertController(title: error.errorTitle, message: error.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
