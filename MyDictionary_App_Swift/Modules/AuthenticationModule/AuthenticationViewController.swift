//
//  AuthenticationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import MBProgressHUD

final class AuthenticationViewController: MDBaseTitledBackViewControllerWithBackgroundImage {
    
    fileprivate let presenter: AuthenticationPresenterInputProtocol
    
    fileprivate static let nicknameTextFieldHeight: CGFloat = 48
    fileprivate static let nicknameTextFieldTopOffset: CGFloat = 24
    fileprivate static let nicknameTextFieldLeftOffset: CGFloat = 16
    fileprivate static let nicknameTextFieldRightOffset: CGFloat = 16
    fileprivate let nicknameTextField: MDTextFieldWithToolBar = {
        let textField: MDTextFieldWithToolBar = .init(rectInset: MDConstants.Rect.defaultInset,
                                                      keyboardToolbar: .init())
        textField.placeholder = KeysForTranslate.nickname.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.font = MDAppStyling.Font.MyriadProItalic.font()
        textField.textColor = MDAppStyling.Color.md_Black_3C3C3C_Light_Appearence.color()
        textField.returnKeyType = .next
        textField.tag = AuthenticationTextFieldTag.nickname.rawValue
        textField.backgroundColor = MDAppStyling.Color.md_White_FFFFFF_Light_Appearence.color()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate static let passwordTextFieldHeight: CGFloat = 48
    fileprivate static let passwordTextFieldTopOffset: CGFloat = 16
    fileprivate static let passwordTextFieldLeftOffset: CGFloat = 16
    fileprivate static let passwordTextFieldRightOffset: CGFloat = 16
    fileprivate let passwordTextField: MDPasswordTextFieldWithToolBar = {
        let textField: MDPasswordTextFieldWithToolBar = .init(height: passwordTextFieldHeight,
                                                              rectInset: MDConstants.Rect.passwordInset,
                                                              keyboardToolbar: .init())
        textField.placeholder = KeysForTranslate.password.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.font = MDAppStyling.Font.MyriadProItalic.font()
        textField.textColor = MDAppStyling.Color.md_Black_3C3C3C_Light_Appearence.color()
        textField.returnKeyType = .go
        textField.isSecureTextEntry = true
        textField.tag = AuthenticationTextFieldTag.password.rawValue
        textField.backgroundColor = MDAppStyling.Color.md_White_FFFFFF_Light_Appearence.color()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate static let loginButtonHeight: CGFloat = 48
    fileprivate static let loginButtonTopOffset: CGFloat = 16
    fileprivate static let loginButtonLeftOffset: CGFloat = 16
    fileprivate static let loginButtonRightOffset: CGFloat = 16
    fileprivate let loginButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDAppStyling.Color.md_Blue_4400D4_Light_Appearence.color()
        button.setTitle(KeysForTranslate.login.localized, for: .normal)
        button.setTitleColor(MDAppStyling.Color.md_White_FFFFFF_Light_Appearence.color(), for: .normal)
        button.titleLabel?.font = MDAppStyling.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var hud: MBProgressHUD = {
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .annularDeterminate
        hud.label.text = KeysForTranslate.pleaseWaitForDataSync.localized
        hud.label.font = MDAppStyling.Font.MyriadProRegular.font()
        hud.label.textColor = MDAppStyling.Color.md_Black_3C3C3C_Light_Appearence.color()
        return hud
    }()
    
    init(presenter: AuthenticationPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: KeysForTranslate.login.localized,
                   navigationBarBackgroundImage: MDAppStyling.Image.background_navigation_bar_0.image,
                   backgroundImage: MDAppStyling.Image.background_typography_1.image)        
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
        roundOffEdges()
        dropShadow()
    }
    
}

// MARK: - AuthenticationPresenterOutputProtocol
extension AuthenticationViewController: AuthenticationPresenterOutputProtocol {
    
    func makePasswordFieldActive() {
        self.passwordTextField.becomeFirstResponder()
    }
    
    func hideKeyboard() {
        MDConstants.Keyboard.hideKeyboard(rootView: self.view)
    }
    
    func showValidationError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: KeysForTranslate.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
    func showProgressHUD() {
        hud.show(animated: true)
    }
    
    func hideProgressHUD() {
        hud.hide(animated: true)
    }
    
    func updateHUDProgress(_ progress: Float) {
        hud.progress = progress
    }
    
}

// MARK: - Add Views
fileprivate extension AuthenticationViewController {
    
    func addViews() {
        addNicknameTextField()
        addPasswordTextField()
        addLoginButton()
    }
    
    func addNicknameTextField() {
        nicknameTextField.delegate = presenter.textFieldDelegate
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingDidChangeAction), for: .editingChanged)
        view.addSubview(nicknameTextField)
    }
    
    func addPasswordTextField() {
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingDidChangeAction), for: .editingChanged)
        passwordTextField.delegate = presenter.textFieldDelegate
        view.addSubview(passwordTextField)
    }
    
    func addLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AuthenticationViewController {
    
    func addConstraints() {
        addNicknameTextFieldConstraints()
        addPasswordTextFieldConstraints()
        addLoginButtonConstraints()
    }
    
    func addNicknameTextFieldConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.nicknameTextField,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: Self.nicknameTextFieldTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.nicknameTextField,
                                                  toItem: self.backgroundImageView,
                                                  constant: Self.nicknameTextFieldLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.nicknameTextField,
                                                   toItem: self.backgroundImageView,
                                                   constant: -Self.nicknameTextFieldRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.nicknameTextField,
                                                    constant: Self.nicknameTextFieldHeight)
        
    }
    
    func addPasswordTextFieldConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.passwordTextField,
                                              attribute: .top,
                                              toItem: self.nicknameTextField,
                                              attribute: .bottom,
                                              constant: Self.passwordTextFieldTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.passwordTextField,
                                                  toItem: self.backgroundImageView,
                                                  constant: Self.passwordTextFieldLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.passwordTextField,
                                                   toItem: self.backgroundImageView,
                                                   constant: -Self.passwordTextFieldRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.passwordTextField,
                                                    constant: Self.passwordTextFieldHeight)
        
    }
    
    func addLoginButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.loginButton,
                                              attribute: .top,
                                              toItem: self.passwordTextField,
                                              attribute: .bottom,
                                              constant: Self.loginButtonTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.loginButton,
                                                  toItem: self.backgroundImageView,
                                                  constant: Self.loginButtonLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.loginButton,
                                                   toItem: self.backgroundImageView,
                                                   constant: -Self.loginButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.loginButton,
                                                    constant: Self.loginButtonHeight)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension AuthenticationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
    }
    
}

// MARK: - Drop Shadow
fileprivate extension AuthenticationViewController {
    
    func dropShadow() {
        dropShadowNicknameTextField()
        dropShadowPasswordTextField()
        dropShadowLoginButtonView()
    }
    
    func dropShadowNicknameTextField() {
        nicknameTextField.dropShadow(color: MDAppStyling.Color.md_Shadow_5200FF_Light_Appearence.color(0.5),
                                     offSet: .init(width: 2, height: 4),
                                     radius: 15)
    }
    
    func dropShadowPasswordTextField() {
        passwordTextField.dropShadow(color: MDAppStyling.Color.md_Shadow_5200FF_Light_Appearence.color(0.5),
                                     offSet: .init(width: 2, height: 4),
                                     radius: 15)
    }
    
    func dropShadowLoginButtonView() {
        loginButton.dropShadow(color: MDAppStyling.Color.md_Blue_4400D4_Light_Appearence.color(0.5),
                               offSet: .init(width: 0,
                                             height: 4),
                               radius: 20)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension AuthenticationViewController {
    
    func roundOffEdges() {
        nicknameTextFieldRoundOffEdges()
        passwordTextFieldRoundOffEdges()
        loginButtonRoundOffEdges()
    }
    
    func nicknameTextFieldRoundOffEdges() {
        nicknameTextField.layer.cornerRadius = 10
    }
    
    func passwordTextFieldRoundOffEdges() {
        passwordTextField.layer.cornerRadius = 10
    }
    
    func loginButtonRoundOffEdges() {
        loginButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Actions
fileprivate extension AuthenticationViewController {
    
    @objc func loginButtonAction() {
        presenter.loginButtonClicked()
    }
    
    @objc func nicknameTextFieldEditingDidChangeAction() {
        presenter.nicknameTextFieldEditingDidChangeAction(nicknameTextField.text)
    }
    
    @objc func passwordTextFieldEditingDidChangeAction() {
        presenter.passwordTextFieldEditingDidChangeAction(passwordTextField.text)
    }
    
}
