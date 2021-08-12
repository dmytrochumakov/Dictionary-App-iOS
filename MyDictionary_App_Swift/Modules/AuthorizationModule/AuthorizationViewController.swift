//
//  AuthorizationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

final class AuthorizationViewController: UIViewController {
    
    fileprivate let presenter: AuthorizationPresenterInputProtocol
    
    fileprivate let defaultLineViewHeight: CGFloat = 0.5
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        textField.tag = AuthTextFieldTag.password.rawValue
        return textField
    }()
    
    fileprivate let passwordTextFieldBottomLineView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppStyling.Color.light_Gray_0.color()
        return view
    }()
    
    fileprivate let loginButtonHeight: CGFloat = 56
    fileprivate let loginButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = ConfigurationAppearanceController.buttonBackgroundColor()
        button.setTitle(KeysForTranslate.login.localized, for: .normal)
        button.setTitleColor(ConfigurationAppearanceController.buttonTextColor(), for: .normal)
        button.titleLabel?.font = AppStyling.Font.default
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate var keyboardHandler: KeyboardHandler!
    
    init(presenter: AuthorizationPresenterInputProtocol) {
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

// MARK: - AuthorizationPresenterOutputProtocol
extension AuthorizationViewController: AuthorizationPresenterOutputProtocol {
    
}

// MARK: - Add Views
fileprivate extension AuthorizationViewController {
    
    func addViews() {
        addScrollView()
        addContentView()
        addNicknameTextField()
        addNicknameTextFieldBottomLineView()
        addPasswordTextField()
        addPasswordTextFieldBottomLineView()
        addLoginButton()
    }
    
    func addScrollView() {
        view.addSubview(scrollView)
    }
    
    func addContentView() {
        scrollView.addSubview(contentView)
    }
    
    func addNicknameTextField() {
        nicknameTextField.delegate = presenter.textFieldDelegate
        contentView.addSubview(nicknameTextField)
    }
    
    func addNicknameTextFieldBottomLineView() {
        contentView.addSubview(nicknameTextFieldBottomLineView)
    }
    
    func addPasswordTextField() {
        passwordTextField.delegate = presenter.textFieldDelegate
        contentView.addSubview(passwordTextField)
    }
    
    func addPasswordTextFieldBottomLineView() {
        contentView.addSubview(passwordTextFieldBottomLineView)
    }
    
    func addLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        contentView.addSubview(loginButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AuthorizationViewController {
    
    func addConstraints() {
        addScrollViewConstraints()
        addContentViewConstraints()
        addNicknameTextFieldConstraints()
        addNicknameTextFieldBottomLineViewConstraints()
        addPasswordTextFieldConstraints()
        addPasswordTextFieldBottomLineViewConstraints()
        addLoginButtonConstraints()
    }
    
    func addScrollViewConstraints() {
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.scrollView,
                                                         toItem: self.view)
    }
    
    func addContentViewConstraints() {
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.contentView,
                                                         toItem: self.scrollView)
        
        NSLayoutConstraint.addEqualCenterXConstraintAndActivate(item: self.contentView,
                                                                toItem: self.scrollView,
                                                                constant: 0)
        
        NSLayoutConstraint.addEqualCenterXConstraintAndActivate(item: self.contentView,
                                                                toItem: self.scrollView,
                                                                constant: 0)
        
        NSLayoutConstraint.addEqualCenterYConstraintAndActivate(item: self.contentView,
                                                                toItem: self.scrollView,
                                                                constant: 0)
    }
    
    func addNicknameTextFieldConstraints() {
        NSLayoutConstraint.addEqualTopConstraintAndActivate(item: self.nicknameTextField,
                                                            toItem: self.contentView,
                                                            constant: self.nicknameTextFieldTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.nicknameTextField,
                                                             toItem: self.contentView,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.nicknameTextField,
                                                              toItem: self.contentView,
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
                                                             toItem: self.contentView,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.nicknameTextFieldBottomLineView,
                                                              toItem: self.contentView,
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
                                                             toItem: self.contentView,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.passwordTextField,
                                                              toItem: self.contentView,
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
                                                             toItem: self.contentView,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.passwordTextFieldBottomLineView,
                                                              toItem: self.contentView,
                                                              constant: 0)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.passwordTextFieldBottomLineView,
                                                               constant: self.defaultLineViewHeight)
    }
    
    func addLoginButtonConstraints() {
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: self.loginButton,
                                                             toItem: self.contentView,
                                                             constant: 0)
        
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: self.loginButton,
                                                              toItem: self.contentView,
                                                              constant: 0)
        
        NSLayoutConstraint.addEqualBottomConstraintAndActivate(item: self.loginButton,
                                                               toItem: self.contentView,
                                                               constant: 0)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.loginButton,
                                                               constant: self.loginButtonHeight)
    }
    
}

// MARK: - Configure UI
fileprivate extension AuthorizationViewController {
    
    func configureUI() {
        configureTitle()
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        configureKeyboardHandler()
    }
    
    func configureTitle() {
        self.title = KeysForTranslate.authorization.localized
    }
    
    func configureKeyboardHandler() {
        self.keyboardHandler = KeyboardHandler.createKeyboardHandler(scrollView: self.scrollView)
    }
    
}

// MARK: - Actions
fileprivate extension AuthorizationViewController {
    
    @objc func loginButtonAction() {
        presenter.loginButtonClicked()
    }
    
}
