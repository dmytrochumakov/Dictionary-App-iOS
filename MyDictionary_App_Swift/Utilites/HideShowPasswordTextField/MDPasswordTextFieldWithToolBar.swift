//
//  MDPasswordTextFieldWithToolBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 12.09.2021.
//

import UIKit

final class MDPasswordTextFieldWithToolBar: HideShowPasswordTextField {
    
    fileprivate let keyboardToolbar: MDKeyboardToolbar
    fileprivate let rectInset: UIEdgeInsets
    
    init(frame: CGRect = .zero,
         rectInset: UIEdgeInsets,
         keyboardToolbar: MDKeyboardToolbar) {
        
        self.keyboardToolbar = keyboardToolbar
        self.rectInset = rectInset
        
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: rectInset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: rectInset)
    }
    
}

// MARK: - Configure UI
fileprivate extension MDPasswordTextFieldWithToolBar {
    
    func configureUI() {
        keyboardToolbar.configureWithDoneButton(textField: self,
                                                target: self,
                                                action: #selector(toolBarDoneButtonAction))
    }
    
}

// MARK: - Actions
fileprivate extension MDPasswordTextFieldWithToolBar {
    
    @objc func toolBarDoneButtonAction() {
        self.resignFirstResponder()
    }
    
}
