//
//  MDTextViewWithToolBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 27.09.2021.
//

import UIKit

open class MDTextViewWithToolBar: RSKPlaceholderTextView {
    
    fileprivate let keyboardToolbar: MDKeyboardToolbar
        
    init(frame: CGRect = .zero,
         keyboardToolbar: MDKeyboardToolbar) {
        
        self.keyboardToolbar = keyboardToolbar
        
        super.init(frame: frame, textContainer: nil)
        configureUI()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure UI
fileprivate extension MDTextViewWithToolBar {
    
    func configureUI() {
        //
        self.textContainerInset = .init(top: 8, left: 9, bottom: 8, right: 8)
        //
        self.placeholderColor = MDUIResources.Color.md_C7C7CD.color()
        //
        keyboardToolbar.configureWithDoneButton(textView: self,
                                                target: self,
                                                action: #selector(toolBarDoneButtonAction))
        //
    }
    
}

// MARK: - Actions
fileprivate extension MDTextViewWithToolBar {
    
    @objc func toolBarDoneButtonAction() {
        self.resignFirstResponder()
    }
    
}
