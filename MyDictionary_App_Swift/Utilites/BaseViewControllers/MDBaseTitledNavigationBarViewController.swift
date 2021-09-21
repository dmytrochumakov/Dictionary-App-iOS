//
//  MDBaseTitledNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.09.2021.
//

import UIKit

open class MDBaseTitledNavigationBarViewController: MDBaseNavigationBarViewController {
    
    fileprivate static let titleLabelHeight: CGFloat = 24
    fileprivate static let titleLabelBottomOffset: CGFloat = 16
    fileprivate static let titleLabelFont: UIFont = MDAppStyling.Font.MyriadProSemiBold.font(ofSize: 17)
    fileprivate static let titleLabelNumberOfLines: Int = 1
    
    fileprivate let titleText: String
    internal let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = titleLabelFont
        label.textColor = MDAppStyling.Color.md_FFFFFF.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = titleLabelNumberOfLines
        return label
    }()
    
    init(title: String, navigationBarBackgroundImage: UIImage) {
        self.titleText = title
        titleLabel.text = title
        super.init(navigationBarBackgroundImage: navigationBarBackgroundImage)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        super.loadView()
        addViews()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    
}

// MARK: - Add View
extension MDBaseTitledNavigationBarViewController {
    
    func addTitleLabel() {
        view.addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraint
extension MDBaseTitledNavigationBarViewController {
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualCenterXConstraint(item: self.titleLabel,
                                                     toItem: self.navigationBarView,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.titleLabel,
                                                   constant: Self.titleLabelWidth(fromText: titleText))
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.titleLabel,
                                                    toItem: self.navigationBarView,
                                                    constant: -Self.titleLabelBottomOffset)
        
    }
    
}

// MARK: - Add Views
fileprivate extension MDBaseTitledNavigationBarViewController {
    
    func addViews() {
        addTitleLabel()
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseTitledNavigationBarViewController {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
}

// MARK: - Title Label Configuration
fileprivate extension MDBaseTitledNavigationBarViewController {
    
    static func titleLabelWidth(fromText text: String) -> CGFloat {
        return text.widthFromLabel(font: Self.titleLabelFont,
                                   height: Self.titleLabelHeight,
                                   numberOfLines: Self.titleLabelNumberOfLines)
    }
    
}
