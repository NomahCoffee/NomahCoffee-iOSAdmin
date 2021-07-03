//
//  ProductEditorView.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/29/21.
//

import UIKit
import SnapKit
import NCUtils

protocol ProductEditorViewDelegate {
    /// Triggers the creation of a new coffee object
    /// - Parameters:
    ///   - name: a `String` of the name of the coffee
    ///   - price: a `Double` of the price of the coffee
    ///   - description: a `String` for the description of the coffee
    ///   - inStock: a `Bool` representing if the coffee is in stock or not
    func createCoffee(name: String, price: Double, description: String, inStock: Bool)
    
    /// Triggers the editing of an existing coffee object
    /// - Parameters:
    ///   - name: a `String` of the new name of the coffee
    ///   - price: a `Double` of the new price of the coffee
    ///   - description: a `String` for the new description of the coffee
    ///   - inStock: a `Bool` representing if the coffee is in stock or not
    func editCoffee(name: String, price: Double, description: String, inStock: Bool)
    
    /// Trigger an error message
    /// - Parameter error: a `ProductEditorError` object representing the specific error to trigger
    func errorFound(_ error: ProductEditorError)
}


class ProductEditorView: UIView {

    // MARK: Properties
    
    var delegate: ProductEditorViewDelegate?
    
    var viewModel: ProductEditorViewModel? {
        didSet {
            nameTextField.text = viewModel?.coffee?.name
            priceTextField.setText(with: viewModel?.coffee?.price ?? 0.0)
            descriptionTextView.text = viewModel?.coffee?.description
            
            // In some cases, the text fields are prefilled (i.e. Edit My User)
            // so we need to check the fulfilled status of the text fields
            nameTextField.isFulfilled = true
            priceTextField.isFulfilled = true
            descriptionTextView.isFulfilled = true
        }
    }
    
    // TODO: Use this to change the fields when more than Coffee objects are included
    var productType: ProductType?
    
    var actionType: ProductEditorActionType? {
        didSet {
            submitButton.setTitle(actionType?.ctaButtonTitle, for: .normal)
        }
    }
    
    private let nameTextField: NCTextField = {
        let nameTextField = NCTextField()
        nameTextField.placeholder = ProductEditorConstants.nameTextFieldPlaceholder
        return nameTextField
    }()
    
    private let priceTextField: NCPriceTextField = {
        let priceTextField = NCPriceTextField()
        priceTextField.placeholder = ProductEditorConstants.priceTextFieldPlaceholder
        return priceTextField
    }()
    
    private let inStockLabel: UILabel = {
        let inStockLabel = UILabel()
        inStockLabel.text = ProductEditorConstants.inStockLabelText
        return inStockLabel
    }()
    
    private let inStockSwitch: UISwitch = {
        let inStockSwitch = UISwitch()
        inStockSwitch.isOn = true
        return inStockSwitch
    }()
    
    private let inStockStack: UIStackView = {
        let inStockStack = UIStackView()
        inStockStack.axis = .horizontal
        return inStockStack
    }()
    
    private let descriptionTextView: NCTextView = {
        let descriptionTextView = NCTextView()
        descriptionTextView.placeholder = ProductEditorConstants.desciptionTextViewPlaceholder
        return descriptionTextView
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
        stack.spacing = ProductEditorConstants.stackSpacing
        return stack
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(priceTextField)
        
        inStockStack.addArrangedSubview(inStockLabel)
        inStockStack.addArrangedSubview(inStockSwitch)
        
        addSubview(stack)
        addSubview(descriptionTextView)
        addSubview(inStockStack)
        addSubview(submitButton)
        
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(UserEditorConstants.stackHorizontalInset) // Remove this constant
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(UserEditorConstants.stackSpacing)
            make.leading.trailing.equalToSuperview().inset(UserEditorConstants.stackHorizontalInset)
            make.height.equalTo(descriptionTextView.snp.width)
        }
        
        inStockStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(UserEditorConstants.stackSpacing)
            make.leading.trailing.equalToSuperview().inset(UserEditorConstants.stackHorizontalInset)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(inStockStack.snp.bottom).offset(UserEditorConstants.stackSpacing)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(UserEditorConstants.submitButtonHeight) //Remove this specific constant
        }
    }
    
    // MARK: Actions
    
    @objc private func submitButtonTapped() {
        if nameTextField.isFulfilled,
           priceTextField.isFulfilled,
           descriptionTextView.isFulfilled,
           let name = nameTextField.text,
           let description = descriptionTextView.text {
        
            switch actionType {
            case .create:
                delegate?.createCoffee(name: name,
                                       price: priceTextField.doubleValue,
                                       description: description,
                                       inStock: inStockSwitch.isOn)
            case .edit:
                delegate?.editCoffee(name: name,
                                     price: priceTextField.doubleValue,
                                     description: description,
                                     inStock: inStockSwitch.isOn)
            default: break
            }
        } else {
            delegate?.errorFound(.generic)
        }
    }
    
}
