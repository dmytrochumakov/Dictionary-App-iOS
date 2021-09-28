//
//  MDAddWordTextViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 28.09.2021.
//

import UIKit

protocol MDAddWordTextViewDelegateProtocol: UITextViewDelegate {
    var wordDescriptionTextViewDidChangeAction: ((String?) -> Void)? { get set }
    var updateWordDescriptionTextViewCounterAction: ((Int) -> Void)? { get set }
}

final class MDAddWordTextViewDelegate: NSObject,
                                       MDAddWordTextViewDelegateProtocol {
    
    var wordDescriptionTextViewDidChangeAction: ((String?) -> Void)?
    var updateWordDescriptionTextViewCounterAction: ((Int) -> Void)?
    
}

extension MDAddWordTextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let result = MDConstants.Text.Counter.result(text: textView.text,
                                                     rangeLength: range.length,
                                                     string: text,
                                                     maxCountCharacters: MDConstants.Text.MaxCountCharacters.wordDescriptionTextView)
        
        if (result.success) {
            updateWordDescriptionTextViewCounterAction?(result.count)
        }
        
        return result.success
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        wordDescriptionTextViewDidChangeAction?(textView.text)
    }
    
}
