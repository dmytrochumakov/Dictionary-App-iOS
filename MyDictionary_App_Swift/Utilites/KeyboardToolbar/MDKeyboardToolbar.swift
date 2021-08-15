//
//  MDKeyboardToolbar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import UIKit

final class MDKeyboardToolbar: UIToolbar {
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDKeyboardToolbar {
    
    func configureWithDoneButton(textField: UITextField,
                                 target: Any?,
                                 action: Selector?) {
        
        self.configureUIWithDoneButton(target: target,
                                       action: action)
        
        textField.inputAccessoryView = self
        
    }
    
}

fileprivate extension MDKeyboardToolbar {
    
    func configureUIWithDoneButton(target: Any?,
                                   action: Selector?) {
        
        self.sizeToFit()
        
        let flexBarButton: UIBarButtonItem = .init(barButtonSystemItem: .flexibleSpace,
                                                   target: nil,
                                                   action: nil)
        
        let doneBarButton: UIBarButtonItem = .init(title: KeysForTranslate.done.localized,
                                                   style: .plain,
                                                   target: target,
                                                   action: action)
        
        self.items = [flexBarButton, doneBarButton]
        
    }
    
}
