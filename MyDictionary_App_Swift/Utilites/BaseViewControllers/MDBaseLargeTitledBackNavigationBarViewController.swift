//
//  MDBaseLargeTitledBackNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

open class MDBaseLargeTitledBackNavigationBarViewController: MDBaseLargeTitledNavigationBarViewController {
    
    internal let backButtonSize: CGSize = .init(width: 40, height: 40)
    internal let backButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDUIResources.Image.back_white_arrow.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(title: String, navigationBarBackgroundImage: UIImage) {
        super.init(title: title, navigationBarBackgroundImage: navigationBarBackgroundImage)
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

// MARK: - Add Views
fileprivate extension MDBaseLargeTitledBackNavigationBarViewController {
    
    func addViews() {
        addBackButton()
    }
    
    func addBackButton() {
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseLargeTitledBackNavigationBarViewController {
    
    func addConstraints() {
        addBackButtonConstraints()
    }
    
    func addBackButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.backButton,
                                              attribute: .bottom,
                                              toItem: self.titleLabel,
                                              attribute: .top,
                                              constant: -16)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.backButton,
                                                  toItem: self.navigationBarView,
                                                  constant: 18)
        
    }
    
}

// MARK: - Actions
fileprivate extension MDBaseLargeTitledBackNavigationBarViewController {
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
}
