//
//  MDTextFieldWithToolBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import UIKit

final class MDTextFieldWithToolBar: UITextField {
    
    fileprivate let keyboardToolbar: MDKeyboardToolbar
    
    init(frame: CGRect = .zero, keyboardToolbar: MDKeyboardToolbar) {
        self.keyboardToolbar = keyboardToolbar
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure UI
fileprivate extension MDTextFieldWithToolBar {
    
    func configureUI() {
        keyboardToolbar.configureWithDoneButton(textField: self,
                                                target: self,
                                                action: #selector(toolBarDoneButtonAction))
    }
    
}

// MARK: - Actions
fileprivate extension MDTextFieldWithToolBar {
 
    @objc func toolBarDoneButtonAction() {
        self.resignFirstResponder()
    }
    
}
