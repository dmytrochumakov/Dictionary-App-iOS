//
//  MDBaseTitledBackNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.09.2021.
//

import UIKit

open class MDBaseTitledBackNavigationBarViewController: MDBaseTitledNavigationBarViewController {
    
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
fileprivate extension MDBaseTitledBackNavigationBarViewController {
    
    func addViews() {
        addBackButton()
    }
    
    func addBackButton() {
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        view.addSubview(backButton)        
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseTitledBackNavigationBarViewController {
    
    func addConstraints() {
        addBackButtonConstraints()
    }
    
    func addBackButtonConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.backButton,
                                                     toItem: self.titleLabel,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.backButton,
                                                  toItem: self.navigationBarView,
                                                  constant: 18)
        
    }
    
}

// MARK: - Actions
fileprivate extension MDBaseTitledBackNavigationBarViewController {
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
}

