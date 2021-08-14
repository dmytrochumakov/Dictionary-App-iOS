//
//  RegistrationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

final class RegistrationViewController: UIViewController {

    fileprivate let presenter: RegistrationPresenterInputProtocol

    fileprivate let defaultLineViewHeight: CGFloat = 0.5
      
    fileprivate let nicknameTextFieldHeight: CGFloat = 40
    fileprivate let nicknameTextFieldTopOffset: CGFloat = 56
    fileprivate let nicknameTextField: UITextField = {
        let textField: UITextField = .init()
        textField.placeholder = KeysForTranslate.nickname.localized
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.font = AppStyling.Font.default
        textField.textColor = ConfigurationAppearanceController.labelTextColor()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .next
        textField.tag = AuthTextFieldTag.nickname.rawValue
        return textField
    }()
    
    fileprivate let nicknameTextFieldBottomLineView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppStyling.Color.light_Gray_0.color()
        return view
    }()
    
    fileprivate let passwordTextFieldHeight: CGFloat = 40
    fileprivate let passwordTextFieldTopOffset: CGFloat = 16
    fileprivate let passwordTextField: UITextField = {
        let textField: UITextField = .init()
        textField.placeholder = KeysForTranslate.password.localized
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.font = AppStyling.Font.default
        textField.textColor = ConfigurationAppearanceController.labelTextColor()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .go
        textField.tag = AuthTextFieldTag.password.rawValue
        return textField
    }()
    
    fileprivate let passwordTextFieldBottomLineView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppStyling.Color.light_Gray_0.color()
        return view
    }()
    
    fileprivate let registerButtonHeight: CGFloat = 56
    fileprivate let registerButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = ConfigurationAppearanceController.buttonBackgroundColor()
        button.setTitle(KeysForTranslate.register.localized, for: .normal)
        button.setTitleColor(ConfigurationAppearanceController.buttonTextColor(), for: .normal)
        button.titleLabel?.font = AppStyling.Font.default
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(presenter: RegistrationPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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

// MARK: - RegistrationPresenterOutputProtocol
extension RegistrationViewController: RegistrationPresenterOutputProtocol {
    
    func makePasswordFieldActive() {
        passwordTextField.becomeFirstResponder()
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
fileprivate extension RegistrationViewController {
    
    func addViews() {
        addNicknameTextField()
        addNicknameTextFieldBottomLineView()
        addPasswordTextField()
        addPasswordTextFieldBottomLineView()
        addRegisterButton()
    }
    
    func addNicknameTextField() {
        nicknameTextField.delegate = presenter.textFieldDelegate
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingDidChangeAction), for: .editingChanged)
        view.addSubview(nicknameTextField)
    }
    
    func addNicknameTextFieldBottomLineView() {
        view.addSubview(nicknameTextFieldBottomLineView)
    }
    
    func addPasswordTextField() {
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingDidChangeAction), for: .editingChanged)
        passwordTextField.delegate = presenter.textFieldDelegate
        view.addSubview(passwordTextField)
    }
    
    func addPasswordTextFieldBottomLineView() {
        view.addSubview(passwordTextFieldBottomLineView)
    }
       
    func addRegisterButton() {
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        view.addSubview(registerButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension RegistrationViewController {
    
    func addConstraints() {
        addNicknameTextFieldConstraints()
        addNicknameTextFieldBottomLineViewConstraints()
        addPasswordTextFieldConstraints()
        addPasswordTextFieldBottomLineViewConstraints()
        addRegisterButtonConstraints()
    }
    
    func addNicknameTextFieldConstraints() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        NSLayoutConstraint.addEqualConstraintAndActivate(item: self.nicknameTextField,
                                                         attribute: .top,
                                                         toItem: navigationBar,
                                                         attribute: .bottom,
                                                         constant: self.nicknameTextFieldTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.nicknameTextField,
                                                             toItem: self.view,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.nicknameTextField,
                                                              toItem: self.view,
                                                              constant: 0)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.nicknameTextField,
                                                               constant: self.nicknameTextFieldHeight)
    }
    
    func addNicknameTextFieldBottomLineViewConstraints() {
        NSLayoutConstraint.addEqualConstraintAndActivate(item: self.nicknameTextFieldBottomLineView,
                                                         attribute: .top,
                                                         toItem: self.nicknameTextField,
                                                         attribute: .bottom,
                                                         constant: 0)
        
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.nicknameTextFieldBottomLineView,
                                                             toItem: self.view,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.nicknameTextFieldBottomLineView,
                                                              toItem: self.view,
                                                              constant: 0)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.nicknameTextFieldBottomLineView,
                                                               constant: self.defaultLineViewHeight)
    }
    
    func addPasswordTextFieldConstraints() {
        NSLayoutConstraint.addEqualConstraintAndActivate(item: self.passwordTextField,
                                                         attribute: .top,
                                                         toItem: self.nicknameTextField,
                                                         attribute: .bottom,
                                                         constant: self.passwordTextFieldTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.passwordTextField,
                                                             toItem: self.view,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.passwordTextField,
                                                              toItem: self.view,
                                                              constant: 0)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.passwordTextField,
                                                               constant: self.passwordTextFieldHeight)
    }
    
    func addPasswordTextFieldBottomLineViewConstraints() {
        NSLayoutConstraint.addEqualConstraintAndActivate(item: self.passwordTextFieldBottomLineView,
                                                         attribute: .top,
                                                         toItem: self.passwordTextField,
                                                         attribute: .bottom,
                                                         constant: 0)
        
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.passwordTextFieldBottomLineView,
                                                             toItem: self.view,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.passwordTextFieldBottomLineView,
                                                              toItem: self.view,
                                                              constant: 0)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.passwordTextFieldBottomLineView,
                                                               constant: self.defaultLineViewHeight)
    }
    
    func addRegisterButtonConstraints() {
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.registerButton,
                                                             toItem: self.view,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.registerButton,
                                                             toItem: self.view,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualBottomConstraintAndActivate(item: self.registerButton,
                                                               toItem: self.view,
                                                               constant: 0)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.registerButton,
                                                               constant: self.registerButtonHeight)
    }
    
}

// MARK: - Configure UI
fileprivate extension RegistrationViewController {
    
    func configureUI() {
        configureTitle()
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
    }
    
    func configureTitle() {
        self.title = KeysForTranslate.registration.localized
    }
    
}

// MARK: - Actions
fileprivate extension RegistrationViewController {
       
    @objc func registerButtonAction() {
        presenter.registerButtonClicked()
    }
    
    @objc func nicknameTextFieldEditingDidChangeAction() {
        presenter.nicknameTextFieldEditingDidChangeAction(nicknameTextField.text)
    }
    
    @objc func passwordTextFieldEditingDidChangeAction() {
        presenter.passwordTextFieldEditingDidChangeAction(passwordTextField.text)
    }
    
}

// MARK: - Hide Keyboard
fileprivate extension RegistrationViewController {
    
    func hideKeyboardFunc() {
        self.view.endEditing(true)
    }
    
}
