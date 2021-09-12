//
//  HideShowPasswordTextField.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 12.09.2021.
//

import UIKit

open class HideShowPasswordTextField: UITextField {
    
    fileprivate var passwordToggleVisibilityView: PasswordToggleVisibilityView!
       
    override public var isSecureTextEntry: Bool {
        didSet {
            // Hack to prevent text from getting cleared when switching secure entry
            // https://stackoverflow.com/a/49771445/1417922
            if self.isFirstResponder {
                _ = self.becomeFirstResponder()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
        
    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        // Hack to prevent text from getting cleared when switching secure entry
        // https://stackoverflow.com/a/49771445/1417922
        let success = super.becomeFirstResponder()
        if self.isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            self.insertText(text)
        }
        return success
    }
    
}

// MARK: - UITextFieldDelegate needed calls
// Implement UITextFieldDelegate when you use this, and forward these calls to this class!
extension HideShowPasswordTextField {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordToggleVisibilityView.eyeState = PasswordToggleVisibilityView.EyeState.closed
        self.isSecureTextEntry = !isSelected
    }
    
}

// MARK: - PasswordToggleVisibilityDelegate
extension HideShowPasswordTextField: PasswordToggleVisibilityDelegate {
    
    func viewWasToggled(isSelected selected: Bool) {
        
        // hack to fix a bug with padding when switching between secureTextEntry state
        let hackString = self.text
        self.text = " "
        self.text = hackString
        
        // hack to save our correct font.  The order here is VERY finicky
        self.isSecureTextEntry = !selected
        
    }
    
}

// MARK: - Private helpers
fileprivate extension HideShowPasswordTextField {
    
    func setupViews() {
        
        let toggleFrame = CGRect(x: 0, y: 0, width: 66, height: frame.height)
        
        passwordToggleVisibilityView = PasswordToggleVisibilityView(frame: toggleFrame)
        passwordToggleVisibilityView.delegate = self
        
        self.keyboardType = .asciiCapable
        self.rightView = passwordToggleVisibilityView
        
        // if we don't do this, the eye flies in on textfield focus!
        self.rightView?.frame = self.rightViewRect(forBounds: self.bounds)
        
        self.rightViewMode = .whileEditing
        // left view hack to add padding
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 3))
        self.leftViewMode = .always
        
    }
    
}
