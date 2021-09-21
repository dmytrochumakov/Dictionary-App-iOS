//
//  MDBaseLargeTitledNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

open class MDBaseLargeTitledNavigationBarViewController: MDBaseLargeNavigationBarViewController {
    
    internal let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDAppStyling.Font.MyriadProSemiBold.font(ofSize: 34)
        label.textColor = MDAppStyling.Color.md_FFFFFF.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, navigationBarBackgroundImage: UIImage) {
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
extension MDBaseLargeTitledNavigationBarViewController {
    
    func addTitleLabel() {
        view.addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraint
extension MDBaseLargeTitledNavigationBarViewController {
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self.navigationBarView,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.titleLabel,
                                                   toItem: self.navigationBarView,
                                                   constant: -16)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.titleLabel,
                                                    toItem: self.navigationBarView,
                                                    constant: -8)
        
    }
    
}

// MARK: - Add Views
fileprivate extension MDBaseLargeTitledNavigationBarViewController {
    
    func addViews() {
        addTitleLabel()
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseLargeTitledNavigationBarViewController {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
}
