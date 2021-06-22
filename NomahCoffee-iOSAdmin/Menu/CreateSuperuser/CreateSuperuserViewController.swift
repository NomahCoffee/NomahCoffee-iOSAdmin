//
//  CreateSuperuserViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/25/21.
//

import UIKit
import SnapKit
import Alamofire

class CreateSuperuserViewController: UIViewController, CreateSuperuserViewDelegate {
    
    // MARK: Properties
    
    lazy var createSuperuserView: CreateSuperuserView = {
        let createSuperuserView = CreateSuperuserView()
        createSuperuserView.viewModel = CreateSuperuserViewModel()
        createSuperuserView.delegate = self
        return createSuperuserView
    }()
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Create Superuser"
        view.addSubview(createSuperuserView)
        
        createSuperuserView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    // MARK: CreateSuperuserViewDelegate
    
    func createSuperuserButtonTapped(email: String, username: String, firstName: String, lastName: String,
                                     password: String, repassword: String, phoneNumber: String) {
        NetworkingManager.createSuperuser(
            with: email,
            username: username,
            firstName: firstName,
            lastName: lastName,
            password: password,
            repassword: repassword,
            phoneNumber: phoneNumber,
            completion: { error in
                if error != nil {
                    let alert = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        )
    }
    
    func errorFound(_ error: CreateSuperuserError) {
        let alert = UIAlertController(title: error.errorTitle, message: error.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
