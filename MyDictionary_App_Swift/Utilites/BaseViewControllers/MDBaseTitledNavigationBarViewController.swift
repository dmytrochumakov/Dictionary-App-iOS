//
//  MDBaseTitledNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.09.2021.
//

import UIKit

open class MDBaseTitledNavigationBarViewController: MDBaseNavigationBarViewController {
    
    internal let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDAppStyling.Font.MyriadProSemiBold.font(ofSize: 17)
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
extension MDBaseTitledNavigationBarViewController {
    
    func addTitleLabel() {
        navigationBarView.addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraint
extension MDBaseTitledNavigationBarViewController {
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualCenterXConstraint(item: self.titleLabel,
                                                     toItem: self.navigationBarView,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.titleLabel,
                                                     toItem: self.navigationBarView,
                                                     constant: .zero)
        
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
