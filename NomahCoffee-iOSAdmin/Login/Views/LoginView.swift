//
//  LoginView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 4/30/21.
//

import UIKit
import SnapKit

protocol LoginViewDelegate {
    /// Trigger a login action
    /// - Parameters:
    ///   - email: a `String` for the user's email
    ///   - password: a `String` for the user's password
    func login(email: String, password: String)
    
    /// Trigger an error message
    /// - Parameter error: a `LoginError` object representing the specific error to trigger
    func errorFound(_ error: LoginError)
}

class LoginView: UIView {
    
    // MARK: Properties
    
    var delegate: LoginViewDelegate?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = LoginConstants.titleLabelTitle
        return titleLabel
    }()
    
    private let emailTextField: NCEmailTextField = {
        let emailTextField = NCEmailTextField()
        emailTextField.placeholder = LoginConstants.emailTextFieldPlaceholder
        return emailTextField
    }()
    
    private let passwordTextField: NCPasswordTextField = {
        let passwordTextField = NCPasswordTextField()
        passwordTextField.placeholder = LoginConstants.passwordTextFieldPlaceholder
        return passwordTextField
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle(LoginConstants.loginButtonTitle, for: .normal)
        loginButton.setTitleColor(.label, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.backgroundColor = .systemGreen
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

        addSubview(stack)
        addSubview(loginButton)
        
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(LoginConstants.stackHorizontalInset)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(stack.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(LoginConstants.loginButtonHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc private func loginButtonTapped() {        
        if emailTextField.isFulfilled,
           passwordTextField.isFulfilled,
           let email = emailTextField.text,
           let password = passwordTextField.text {
            delegate?.login(email: email, password: password)
        } else {
            delegate?.errorFound(.generic)
        }
    }
    
    // MARK: Public Functions
    
    /// Clear all text fields associated with the login view
    public func clearTextFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
}
