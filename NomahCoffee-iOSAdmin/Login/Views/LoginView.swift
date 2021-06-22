//
//  LoginView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import UIKit
import SnapKit

protocol LoginViewDelegate {
    func loginButtonTapped(email: String, password: String)
    func errorFound(_ error: LoginError)
}

class LoginView: UIView {
    
    // MARK: Properties
    
    var delegate: LoginViewDelegate?
    
    var viewModel: LoginViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleLabelTitle
            emailTextField.placeholder = viewModel?.emailTextFieldPlaceholder
            passwordTextField.placeholder = viewModel?.passwordTextFieldPlaceholder
            loginButton.titleLabel?.text = viewModel?.loginButtonTitle
        }
    }
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        return emailTextField
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = .red
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = LoginConstants.stackSpacing
        return stack
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(loginButton)
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, email != "" else {
            delegate?.errorFound(.missingEmail)
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            delegate?.errorFound(.missingPassword)
            return
        }
        
        delegate?.loginButtonTapped(email: email, password: password)
    }
    
    func clearTextFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
}
