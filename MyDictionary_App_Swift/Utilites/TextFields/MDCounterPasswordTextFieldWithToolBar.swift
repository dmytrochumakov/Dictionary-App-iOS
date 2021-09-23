//
//  MDCounterPasswordTextFieldWithToolBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 14.09.2021.
//

import UIKit

final class MDCounterPasswordTextFieldWithToolBar: MDPasswordTextFieldWithToolBar {
    
    fileprivate let counterLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font(ofSize: 11)
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override init(height: CGFloat,
                  frame: CGRect = .zero,
                  rectInset: UIEdgeInsets,
                  keyboardToolbar: MDKeyboardToolbar) {
        
        super.init(height: height,
                   frame: frame,
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
extension MDCounterPasswordTextFieldWithToolBar {
    
    func updateCounter(currentCount: Int, maxCount: Int) {
        counterLabel.text = String(currentCount) + MDConstants.StaticText.forwardSlash + String(maxCount)
    }
    
}

// MARK: - Add Views
fileprivate extension MDCounterPasswordTextFieldWithToolBar {
    
    func addViews() {
        addCounterLabe()
    }
    
    func addCounterLabe() {
        addSubview(counterLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDCounterPasswordTextFieldWithToolBar {
    
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
