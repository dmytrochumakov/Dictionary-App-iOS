//
//  MDBaseLargeTitledBackViewControllerWithBackgroundImage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.09.2021.
//

import UIKit

open class MDBaseLargeTitledBackViewControllerWithBackgroundImage: MDBaseLargeNavigationBarAndBackgroundImageViewController {
    
    internal let backButtonSize: CGSize = .init(width: 40, height: 40)
    internal let backButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDUIResources.Image.back_white_arrow.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    internal let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProSemiBold.font(ofSize: 34)
        label.textColor = MDUIResources.Color.md_FFFFFF.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String, navigationBarBackgroundImage: UIImage, backgroundImage: UIImage) {
        titleLabel.text = title
        super.init(navigationBarBackgroundImage: navigationBarBackgroundImage, backgroundImage: backgroundImage)
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
fileprivate extension MDBaseLargeTitledBackViewControllerWithBackgroundImage {
    
    func addViews() {
        addTitleLabel()
        addBackButton()
    }
    
    func addTitleLabel() {
        view.addSubview(titleLabel)
    }
    
    func addBackButton() {
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseLargeTitledBackViewControllerWithBackgroundImage {
    
    func addConstraints() {
        addTitleLabelConstraints()
        addBackButtonConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self.navigationBarView,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.titleLabel,
                                                   toItem: self.navigationBarView,
                                                   constant: -16)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.titleLabel,
                                                    toItem: self.navigationBarView,
                                                    constant: -16)
        
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
fileprivate extension MDBaseLargeTitledBackViewControllerWithBackgroundImage {
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
}
