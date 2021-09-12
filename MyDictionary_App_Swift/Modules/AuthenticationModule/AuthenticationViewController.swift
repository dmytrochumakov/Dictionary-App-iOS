//
//  AuthenticationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

final class AuthenticationViewController: BaseAuthViewController {
    
    fileprivate let presenter: AuthenticationPresenterInputProtocol
    
    fileprivate let backButtonSize: CGSize = .init(width: 40, height: 40)
    fileprivate let backButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDAppStyling.Image.back_white_arrow.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let loginLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDAppStyling.Font.MyriadProSemiBold.font(ofSize: 34)
        label.text = KeysForTranslate.login.localized
        label.textColor = MDAppStyling.Color.md_White_0_Light_Appearence.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(presenter: AuthenticationPresenterInputProtocol) {
        self.presenter = presenter
        super.init()
        updateBackgroundImage(MDAppStyling.Image.background_typography_1.image)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        addViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    
}

// MARK: - AuthenticationPresenterOutputProtocol
extension AuthenticationViewController: AuthenticationPresenterOutputProtocol {
    
    func makePasswordFieldActive() {
        
    }
    
    func hideKeyboard() {
        self.hideKeyboardFunc()
    }
    
    func showValidationError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: KeysForTranslate.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
}

// MARK: - Add Views
fileprivate extension AuthenticationViewController {
    
    func addViews() {
        addLoginLabel()
        addBackButton()
    }
    
    func addLoginLabel() {
        view.addSubview(loginLabel)
    }
    
    func addBackButton() {
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AuthenticationViewController {
    
    func addConstraints() {
        addLoginLabelConstraints()
        addBackButtonConstraints()
    }
    
    func addLoginLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.loginLabel,
                                                             toItem: self.navigationBarView,
                                                             constant: 16)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.loginLabel,
                                                              toItem: self.navigationBarView,
                                                              constant: -16)
        
        NSLayoutConstraint.addEqualBottomConstraintAndActivate(item: self.loginLabel,
                                                               toItem: self.navigationBarView,
                                                               constant: -16)
        
    }
    
    func addBackButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraintAndActivate(item: self.backButton,
                                                         attribute: .bottom,
                                                         toItem: self.loginLabel,
                                                         attribute: .top,
                                                         constant: -16)
        
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.backButton,
                                                             toItem: self.navigationBarView,
                                                             constant: 18)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension AuthenticationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
    }
    
}

// MARK: - Actions
fileprivate extension AuthenticationViewController {
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Hide Keyboard
fileprivate extension AuthenticationViewController {
    
    func hideKeyboardFunc() {
        self.view.endEditing(true)
    }
    
}
