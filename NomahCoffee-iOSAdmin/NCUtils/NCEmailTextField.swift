//
//  NCEmailTextField.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit

class NCEmailTextField: NCTextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        isFulfilled = false
        keyboardType = .emailAddress
        autocapitalizationType = .none
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateFulfilledStatus() {
        if let text = text {
            isFulfilled = isValidEmail(text)
        } else {
            isFulfilled = false
        }
    }
    
    override func textFieldDidChange() {
        guard let text = text else { return }
        
        isFulfilled = isValidEmail(text)
        layer.borderColor = isFulfilled ? UIColor.secondaryLabel.cgColor : UIColor.red.cgColor
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
