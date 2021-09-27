//
//  MDCounterTextViewWithToolBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 27.09.2021.
//

import UIKit

final class MDCounterTextViewWithToolBar: RSKPlaceholderTextView {
    
    fileprivate let counterLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font(ofSize: 11)
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    fileprivate let keyboardToolbar: MDKeyboardToolbar
    
    init(frame: CGRect = .zero,
         keyboardToolbar: MDKeyboardToolbar) {
        
        self.keyboardToolbar = keyboardToolbar
        
        super.init(frame: frame, textContainer: nil)
        
        addViews()
        configureUI()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
}

// MARK: - Update Counter
extension MDCounterTextViewWithToolBar {
    
    func updateCounter(currentCount: Int, maxCount: Int) {
        counterLabel.text = String(currentCount) + MDConstants.StaticText.forwardSlash + String(maxCount)
    }
    
}

// MARK: - Add Views
fileprivate extension MDCounterTextViewWithToolBar {
    
    func addViews() {
        addCounterLabel()
    }
    
    func addCounterLabel() {
        addSubview(counterLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDCounterTextViewWithToolBar {
    
    func addConstraints() {
        addCounterLabelConstraints()
    }
    
    func addCounterLabelConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.counterLabel,
                                              attribute: .top,
                                              toItem: self,
                                              attribute: .bottom,
                                              constant: 4)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.counterLabel,
                                                  toItem: self,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.counterLabel,
                                                   toItem: self,
                                                   constant: -4)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension MDCounterTextViewWithToolBar {
    
    func configureUI() {
        //
        self.textContainerInset = .init(top: 8, left: 9, bottom: 8, right: 9)
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
fileprivate extension MDCounterTextViewWithToolBar {
    
    @objc func toolBarDoneButtonAction() {
        self.resignFirstResponder()
    }
    
}
