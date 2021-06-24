//
//  UserEditorViewController.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit
import SnapKit
import Alamofire

class UserEditorViewController: UIViewController, UserEditorViewDelegate {
    
    // MARK: Properties
    
    var viewModel: UserEditorViewModel?
    
    var actionType: UserEditorActionType?
    
    lazy var userEditorView: UserEditorView = {
        guard
            let viewModel = viewModel,
            let actionType = actionType
        else {
            return UserEditorView()
        }
        
        let userEditorView = UserEditorView()
        userEditorView.viewModel = viewModel
        userEditorView.actionType = actionType
        userEditorView.delegate = self
        return userEditorView
    }()
        
    // MARK: Init
    
    convenience init(actionType: UserEditorActionType) {
        self.init(nibName: nil, bundle: nil)
        
        self.actionType = actionType
        
        switch actionType {
        case .create:
            viewModel = UserEditorViewModel(user: nil)
        case .editMe:
            NetworkingManager.getMyUser(completion: { user in
                self.viewModel = UserEditorViewModel(user: user)
            })
        case .editOther(let user):
            self.viewModel = UserEditorViewModel(user: user)
        }
        
        title = actionType.navigationTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(userEditorView)
        
        userEditorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: UserEditorViewDelegate
    
    func createSuperuser(email: String, username: String, firstName: String, lastName: String, password: String, repassword: String) {
        NetworkingManager.createSuperuser(
            with: email,
            username: username,
            firstName: firstName,
            lastName: lastName,
            password: password,
            repassword: repassword,
            completion: { error in
                if error != nil {
                    let alert = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }

                self.navigationController?.popViewController(animated: true)
            }
        )
    }
    
    func editSuperuser(email: String, username: String, firstName: String, lastName: String) {
        NetworkingManager.editSuperuser(
            with: email,
            username: username,
            firstName: firstName,
            lastName: lastName,
            completion: { error in
                if error != nil {
                    let alert = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }

                self.navigationController?.popViewController(animated: true)
            }
        )
    }
    
    func errorFound(_ error: UserEditorError) {
        let alert = UIAlertController(title: error.errorTitle, message: error.errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
