//
//  MDCounterTextFieldWithToolBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.09.2021.
//

import UIKit

final class MDCounterTextFieldWithToolBar: MDTextFieldWithToolBar {
    
    fileprivate let counterLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 11)
        label.textColor = MDAppStyling.Color.md_Black_1_Light_Appearence.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect = .zero,
                  rectInset: UIEdgeInsets,
                  keyboardToolbar: MDKeyboardToolbar) {
        
        super.init(frame: frame,
                   rectInset: rectInset,
                   keyboardToolbar: keyboardToolbar)
        
        addViews()
        
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
extension MDCounterTextFieldWithToolBar {
    
    func updateCounter(currentCount: Int, maxCount: Int) {
        counterLabel.text = String(currentCount) + MDConstants.StaticText.forwardSlash + String(maxCount)
    }
    
}

// MARK: - Add Views
fileprivate extension MDCounterTextFieldWithToolBar {
    
    func addViews() {
        addCounterLabe()
    }
    
    func addCounterLabe() {
        addSubview(counterLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDCounterTextFieldWithToolBar {
    
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
