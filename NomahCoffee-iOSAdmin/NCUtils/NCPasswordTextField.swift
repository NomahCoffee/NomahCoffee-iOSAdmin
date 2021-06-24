//
//  NCPasswordTextField.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit

class NCPasswordTextField: NCTextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        isFulfilled = false
        autocapitalizationType = .none
        isSecureTextEntry = true
        
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateFulfilledStatus() {
        if let text = text {
            isFulfilled = isValidPassword(text)
        } else {
            isFulfilled = false
        }
    }
    
    override func textFieldDidChange() {
        guard let text = text else { return }
        
        isFulfilled = isValidPassword(text)
        layer.borderColor = isFulfilled ? UIColor.secondaryLabel.cgColor : UIColor.red.cgColor
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count > 7
    }

}
