//
//  UserEditorView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit
import SnapKit
import NCUtils

protocol UserEditorViewDelegate {
    /// Trigger the creation of a new superuser
    /// - Parameters:
    ///   - email: a `String` for the new superuser's email
    ///   - username: a `String` for the new superuser's username
    ///   - firstName: a `String` for the new superuser's first name
    ///   - lastName: a `String` for the new superuser's last name
    ///   - password: a `String` for the new superuser's password
    ///   - repassword: a `String` for the new superuser's password which must match the `password` entry
    func createSuperuser(email: String, username: String, firstName: String, lastName: String, password: String, repassword: String)
    
    /// Trigger the editing of an existing superuser
    /// - Parameters:
    ///   - email: a `String` for the existing superuser's email
    ///   - username: a `String` for the existing superuser's username
    ///   - firstName: a `String` for the existing superuser's first name
    ///   - lastName: a `String` for the existing superuser's last name
    func editSuperuser(email: String, username: String, firstName: String, lastName: String)
    
    /// Trigger an error message
    /// - Parameter error: a `UserEditorError` object representing the specific error to trigger
    func errorFound(_ error: UserEditorError)
}

class UserEditorView: UIView {
        
    // MARK: Properties
    
    var delegate: UserEditorViewDelegate?
    
    var viewModel: UserEditorViewModel? {
        didSet {
            emailTextField.text = viewModel?.user?.email
            usernameTextField.text = viewModel?.user?.username
            firstNameTextField.text = viewModel?.user?.firstName
            lastNameTextField.text = viewModel?.user?.lastName
            
            // In some cases, the text fields are prefilled (i.e. Edit My User)
            // so we need to check the fulfilled status of the text fields
            emailTextField.isFulfilled = true
            usernameTextField.isFulfilled = true
            firstNameTextField.isFulfilled = true
            lastNameTextField.isFulfilled = true
        }
    }
    
    var actionType: UserEditorActionType? {
        didSet {
            // Editing another user is not currently supported so disable the button
            if actionType != .create && actionType != .editMe {
                submitButton.isEnabled = false
                submitButton.backgroundColor = .secondarySystemBackground
            }
            submitButton.setTitle(actionType?.ctaButtonTitle, for: .normal)
            layoutSubviews()
        }
    }
    
    private let emailTextField: NCEmailTextField = {
        let emailTextField = NCEmailTextField()
        emailTextField.placeholder = UserEditorConstants.emailTextFieldPlaceholder
        return emailTextField
    }()
    
    private let usernameTextField: NCTextField = {
        let usernameTextField = NCTextField()
        usernameTextField.autocapitalizationType = .none
        usernameTextField.placeholder = UserEditorConstants.usernameTextFieldPlaceholder
        return usernameTextField
    }()
    
    private let firstNameTextField: NCTextField = {
        let firstNameTextField = NCTextField()
        firstNameTextField.placeholder = UserEditorConstants.firstNameTextFieldPlaceholder
        return firstNameTextField
    }()
    
    private let lastNameTextField: NCTextField = {
        let lastNameTextField = NCTextField()
        lastNameTextField.placeholder = UserEditorConstants.lastNameTextFieldPlaceholder
        return lastNameTextField
    }()
    
    private let passwordTextField: NCPasswordTextField = {
        let passwordTextField = NCPasswordTextField()
        passwordTextField.placeholder = UserEditorConstants.passwordTextFieldPlaceholder
        return passwordTextField
    }()
    
    private let repasswordTextField: NCPasswordTextField = {
        let repasswordTextField = NCPasswordTextField()
        repasswordTextField.placeholder = UserEditorConstants.repasswordTextFieldPlaceholder
        return repasswordTextField
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.setTitleColor(.label, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.backgroundColor = .systemGreen
        return submitButton
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = UserEditorConstants.stackSpacing
        return stack
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(usernameTextField)
        stack.addArrangedSubview(firstNameTextField)
        stack.addArrangedSubview(lastNameTextField)
        if actionType == .create {
            stack.addArrangedSubview(passwordTextField)
            stack.addArrangedSubview(repasswordTextField)
        }
        
        addSubview(stack)
        addSubview(submitButton)
        
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UserEditorConstants.stackHorizontalInset)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(stack.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(UserEditorConstants.submitButtonHeight)
        }
    }
    
    // MARK: Actions
    
    @objc func submitButtonTapped() {
        if emailTextField.isFulfilled,
           usernameTextField.isFulfilled,
           firstNameTextField.isFulfilled,
           lastNameTextField.isFulfilled,
           let email = emailTextField.text,
           let username = usernameTextField.text,
           let firstName = firstNameTextField.text,
           let lastName = lastNameTextField.text {
            
            if actionType == .create {
                if passwordTextField.isFulfilled,
                   repasswordTextField.isFulfilled,
                   let password = passwordTextField.text,
                   let repassword = repasswordTextField.text {
                    delegate?.createSuperuser(email: email,
                                              username: username,
                                              firstName: firstName,
                                              lastName: lastName,
                                              password: password,
                                              repassword: repassword)
                } else {
                    delegate?.errorFound(.generic)
                }
                
            } else {
                delegate?.editSuperuser(email: email,
                                       username: username,
                                       firstName: firstName,
                                       lastName: lastName)
            }
        } else {
            delegate?.errorFound(.generic)
        }
    }
    
}
