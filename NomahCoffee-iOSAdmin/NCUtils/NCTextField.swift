//
//  NCTextField.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/24/21.
//

import UIKit

class NCTextField: UITextField {
    
    public var isFulfilled: Bool = true

    private var textInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = 4
        
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    func updateFulfilledStatus() {
        if let text = text {
            isFulfilled = text.count > 2
        } else {
            isFulfilled = false
        }
    }
    
    @objc func textFieldDidChange() {
        guard let text = text else { return }
        
        isFulfilled = text.count > 2
        layer.borderColor = isFulfilled ? UIColor.secondaryLabel.cgColor : UIColor.red.cgColor
    }
    
    
}
