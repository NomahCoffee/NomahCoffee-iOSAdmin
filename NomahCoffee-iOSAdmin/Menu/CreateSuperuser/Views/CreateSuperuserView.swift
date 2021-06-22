//
//  CreateSuperuserView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import UIKit
import SnapKit

protocol CreateSuperuserViewDelegate {
    func createSuperuserButtonTapped(email: String, username: String, firstName: String, lastName: String,
                                     password: String, repassword: String, phoneNumber: String)
    func errorFound(_ error: CreateSuperuserError)
}

class CreateSuperuserView: UIView {
    
    // MARK: Properties
    
    var delegate: CreateSuperuserViewDelegate?
    
    var viewModel: CreateSuperuserViewModel? {
        didSet {
            emailTextField.placeholder = viewModel?.emailTextFieldPlaceholder
            usernameTextField.placeholder = viewModel?.usernameTextFieldPlaceholder
            firstNameTextField.placeholder = viewModel?.firstNameTextFieldPlaceholder
            lastNameTextField.placeholder = viewModel?.lastNameTextFieldPlaceholder
            passwordTextField.placeholder = viewModel?.passwordTextFieldPlaceholder
            repasswordTextField.placeholder = viewModel?.repasswordTextFieldPlaceholder
            phoneNumberTextField.placeholder = viewModel?.phoneNumberTextFieldPlaceholder
//            loginButton.titleLabel?.text = viewModel?.loginButtonTitle
        }
    }
    
    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        return emailTextField
    }()
    
    private let usernameTextField: UITextField = {
        let usernameTextField = UITextField()
        usernameTextField.autocapitalizationType = .none
        return usernameTextField
    }()
    
    private let firstNameTextField: UITextField = {
        let firstNameTextField = UITextField()
        return firstNameTextField
    }()
    
    private let lastNameTextField: UITextField = {
        let lastNameTextField = UITextField()
        return lastNameTextField
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private let repasswordTextField: UITextField = {
        let repasswordTextField = UITextField()
        repasswordTextField.autocapitalizationType = .none
        repasswordTextField.isSecureTextEntry = true
        return repasswordTextField
    }()
    
    private let phoneNumberTextField: UITextField = {
        let phoneNumberTextField = UITextField()
        phoneNumberTextField.autocapitalizationType = .none
        phoneNumberTextField.keyboardType = .phonePad
        return phoneNumberTextField
    }()
    
    private let createSuperUserButton: UIButton = {
        let createSuperUserButton = UIButton()
        createSuperUserButton.setTitle("Create Super User", for: .normal)
        createSuperUserButton.addTarget(self, action: #selector(createSuperUserButtonTapped), for: .touchUpInside)
        return createSuperUserButton
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = CreateSuperuserConstants.stackSpacing
        return stack
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(usernameTextField)
        stack.addArrangedSubview(firstNameTextField)
        stack.addArrangedSubview(lastNameTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(repasswordTextField)
        stack.addArrangedSubview(phoneNumberTextField)
        stack.addArrangedSubview(createSuperUserButton)
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func createSuperUserButtonTapped() {
        guard let email = emailTextField.text, email != "" else {
            delegate?.errorFound(.missingEmail)
            return
        }
        
        guard let username = usernameTextField.text, username != "" else {
            delegate?.errorFound(.missingUsername)
            return
        }
        
        guard let firstName = firstNameTextField.text, firstName != "" else {
            delegate?.errorFound(.missingFirstName)
            return
        }
        
        guard let lastName = lastNameTextField.text, lastName != "" else {
            delegate?.errorFound(.missingLastName)
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            delegate?.errorFound(.missingPassword)
            return
        }
        
        guard let repassword = repasswordTextField.text, repassword != "" else {
            delegate?.errorFound(.missingRepassword)
            return
        }
        
        guard let phoneNumber = phoneNumberTextField.text, phoneNumber != "" else {
            delegate?.errorFound(.missingPhoneNumber)
            return
        }
        
        delegate?.createSuperuserButtonTapped(email: email,
                                              username: username,
                                              firstName: firstName,
                                              lastName: lastName,
                                              password: password,
                                              repassword: repassword,
                                              phoneNumber: phoneNumber)
    }
    
}

