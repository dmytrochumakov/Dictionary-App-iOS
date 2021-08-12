//
//  KeyboardHandler.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 12.08.2021.
//

import UIKit

@objcMembers
final class Info: NSObject {
    var duration: Double = 0
    var keyboardFrame: CGRect = CGRect.zero
    var options: UIView.AnimationOptions = []
}

final class KeyboardHandler: NSObject {
    
    typealias EventCallback = ( _ willShow: Bool, _ info: Info) -> Void
    
    fileprivate let onStart: EventCallback?
    fileprivate let onAnimation: EventCallback?
    fileprivate let onCompletion: EventCallback?
    
    fileprivate var enabled: Bool
    
    @objc init(enabled: Bool = true,
               before: EventCallback? = nil,
               animations: EventCallback? = nil,
               completion: EventCallback? = nil) {
        
        self.enabled = enabled
        self.onStart = before
        self.onAnimation = animations
        self.onCompletion = completion
        
        super.init()
        subscribe()
        
    }
    
    deinit {
        unsubscribe()
        debugPrint(Self.self, #function)
    }
    
}

// MARK: - Create Keyboard Handler
extension KeyboardHandler {
    
    static func createKeyboardHandler(scrollView: UIScrollView) -> KeyboardHandler {
        let animations: KeyboardHandler.EventCallback = { willShow, info in
            let scrollViewIntersection = scrollView.frame.intersection(info.keyboardFrame).height
            let bottomInsets = willShow ? scrollViewIntersection : .zero
            let scrollViewInsets = UIEdgeInsets(top: .zero,
                                                left: .zero,
                                                bottom: bottomInsets,
                                                right: .zero)
            
            scrollView.contentInset = scrollViewInsets
        }
        
        return KeyboardHandler(animations: animations)
    }
    
}

// MARK: - Helper
fileprivate extension KeyboardHandler {
    
    func infoFromNotification(_ notification: Notification) -> Info? {
        let name = notification.name
        let info: Info = Info()
        guard name == UIResponder.keyboardWillShowNotification || name == UIResponder.keyboardWillHideNotification,
              let userInfo = (notification as NSNotification).userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return nil }
        
        info.keyboardFrame = keyboardFrameValue.cgRectValue
        info.options = [.beginFromCurrentState, UIView.AnimationOptions(rawValue: curveValue)]
        info.duration = duration
        
        return info
    }
    
}

// MARK: - Actions
fileprivate extension KeyboardHandler {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard enabled == true, let info = infoFromNotification(notification) else { return }
        
        onStart?(true, info)
        let animations: () -> Void = {
            self.onAnimation?(true, info)
        }
        let completion: (Bool) -> Void = {_ in
            self.onCompletion?(true, info)
        }
        
        UIView.animate(withDuration: info.duration,
                       delay: 0,
                       options: info.options,
                       animations: animations,
                       completion: completion)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard enabled == true, let info = infoFromNotification(notification) else { return }
        
        onStart?(false, info)
        let animations: () -> Void = {
            self.onAnimation?(false, info)
        }
        let completion: (Bool) -> Void = { _ in
            self.onCompletion?(false, info)
        }
        UIView.animate(withDuration: info.duration,
                       delay: 0,
                       options: info.options,
                       animations: animations,
                       completion: completion)
    }
    
}

// MARK: - Subscribe
fileprivate extension KeyboardHandler {
    
    func subscribe() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
}

// MARK: - Unsubscribe
fileprivate extension KeyboardHandler {
    
    func unsubscribe() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
