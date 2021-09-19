//
//  MDSearchTextField.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 19.09.2021.
//

import UIKit

open class MDSearchTextField: UITextField {
    
    fileprivate let rectInset: UIEdgeInsets
    
    fileprivate static let searchIconImageViewSize: CGSize = .init(width: 14, height: 14)
    fileprivate static let searchIconImageViewLeftOffset: CGFloat = 10
    fileprivate let searchIconImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.search.image
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(frame: CGRect = .zero,
         rectInset: UIEdgeInsets = MDConstants.Rect.searchInset(searchIconImageViewLeftOffset: searchIconImageViewLeftOffset)) {
        
        self.rectInset = rectInset
        
        super.init(frame: frame)
        addViews()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: rectInset)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: rectInset)
    }
    
}

// MARK: - Add Views
fileprivate extension MDSearchTextField {
    
    func addViews() {
        addSearchIconImageView()
    }
    
    func addSearchIconImageView() {
        addSubview(searchIconImageView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDSearchTextField {
    
    func addConstraints() {
        addSearchIconImageViewConstraints()
    }
    
    func addSearchIconImageViewConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.searchIconImageView,
                                                     toItem: self,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.searchIconImageView,
                                                  toItem: self,
                                                  constant: Self.searchIconImageViewLeftOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.searchIconImageView,
                                                    constant: Self.searchIconImageViewSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.searchIconImageView,
                                                   constant: Self.searchIconImageViewSize.width)
        
    }
    
}
