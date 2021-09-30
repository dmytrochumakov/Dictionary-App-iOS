//
//  MDWordTextFieldDelegateImplementation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 30.09.2021.
//

import UIKit

protocol MDWordTextFieldDelegateImplementationProtocol: UITextFieldDelegate {
    var wordTextFieldShouldReturnAction: (() -> Void)? { get set }
    var updateWordTextFieldCounterAction: ((Int) -> Void)? { get set }
    var wordTextFieldShouldClearAction: (() -> Void)? { get set }
}

final class MDWordTextFieldDelegateImplementation: NSObject,
                                                   MDWordTextFieldDelegateImplementationProtocol {
    
    
    var wordTextFieldShouldReturnAction: (() -> Void)?
    var updateWordTextFieldCounterAction: ((Int) -> Void)?
    var wordTextFieldShouldClearAction: (() -> Void)?
    
}

extension MDWordTextFieldDelegateImplementation {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        wordTextFieldShouldClearAction?()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wordTextFieldShouldReturnAction?()
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let result = MDConstants.Text.Counter.result(text: textField.text,
                                                     rangeLength: range.length,
                                                     string: string,
                                                     maxCountCharacters: MDConstants.Text.MaxCountCharacters.wordTextField)
        
        if (result.success) {
            updateWordTextFieldCounterAction?(result.count)
        }
        
        return result.success
        
    }
    
}
