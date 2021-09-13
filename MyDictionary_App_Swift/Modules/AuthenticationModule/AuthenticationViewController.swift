//
//  AuthenticationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

final class AuthenticationViewController: BaseDetailAuthViewController {
    
    fileprivate let presenter: AuthenticationPresenterInputProtocol
    
    fileprivate static let nicknameTextFieldHeight: CGFloat = 48
    fileprivate static let nicknameTextFieldTopOffset: CGFloat = 24
    fileprivate static let nicknameTextFieldLeftOffset: CGFloat = 16
    fileprivate static let nicknameTextFieldRightOffset: CGFloat = 16
    fileprivate let nicknameTextField: MDTextFieldWithToolBar = {
        let textField: MDTextFieldWithToolBar = .init(frame: newFrameForNicknameTextField(navBarHeight: defaultNavigationBarViewHeight),
                                                      rectInset: MDConstants.Rect.defaultInset,
                                                      keyboardToolbar: .init())
        textField.placeholder = KeysForTranslate.nickname.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.font = MDAppStyling.Font.MyriadProItalic.font(ofSize: 17)
        textField.textColor = MDAppStyling.Color.md_Black_1_Light_Appearence.color()
        textField.returnKeyType = .next
        textField.tag = AuthenticationTextFieldTag.nickname.rawValue
        textField.backgroundColor = MDAppStyling.Color.md_White_0_Light_Appearence.color()
        return textField
    }()
    
    fileprivate static let passwordTextFieldHeight: CGFloat = 48
    fileprivate static let passwordTextFieldTopOffset: CGFloat = 16
    fileprivate static let passwordTextFieldLeftOffset: CGFloat = 16
    fileprivate static let passwordTextFieldRightOffset: CGFloat = 16
    fileprivate let passwordTextField: MDPasswordTextFieldWithToolBar = {
        let textField: MDPasswordTextFieldWithToolBar = .init(frame: newFrameForPasswordTextField(navBarHeight: defaultNavigationBarViewHeight),
                                                              rectInset: MDConstants.Rect.passwordInset,
                                                              keyboardToolbar: .init())
        textField.placeholder = KeysForTranslate.password.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.font = MDAppStyling.Font.MyriadProItalic.font(ofSize: 17)
        textField.textColor = MDAppStyling.Color.md_Black_1_Light_Appearence.color()
        textField.returnKeyType = .go
        textField.isSecureTextEntry = true
        textField.tag = AuthenticationTextFieldTag.password.rawValue
        textField.backgroundColor = MDAppStyling.Color.md_White_0_Light_Appearence.color()
        return textField
    }()
    
    fileprivate static let loginButtonHeight: CGFloat = 48
    fileprivate static let loginButtonTopOffset: CGFloat = 16
    fileprivate static let loginButtonLeftOffset: CGFloat = 16
    fileprivate static let loginButtonRightOffset: CGFloat = 16
    fileprivate let loginButton: UIButton = {
        let button: UIButton = .init(frame: newFrameForLoginButton(navBarHeight: defaultNavigationBarViewHeight))
        button.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
        button.setTitle(KeysForTranslate.login.localized, for: .normal)
        button.setTitleColor(MDAppStyling.Color.md_White_0_Light_Appearence.color(), for: .normal)
        button.titleLabel?.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        return button
    }()
    
    init(presenter: AuthenticationPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: KeysForTranslate.login.localized)
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
        roundOffEdges()
    }
    
}

// MARK: - AuthenticationPresenterOutputProtocol
extension AuthenticationViewController: AuthenticationPresenterOutputProtocol {
    
    func makePasswordFieldActive() {
        self.passwordTextField.becomeFirstResponder()
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

// MARK: - Configure UI
fileprivate extension AuthenticationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        updateFrame()
        dropShadow()
    }
    
}

// MARK: - Update Frame
fileprivate extension AuthenticationViewController {
    
    func updateFrame() {
        updateNicknameTextFieldFrame()
        updatePasswordTextFieldFrame()
        updateLoginButtonFrame()
    }
    
    func updateNicknameTextFieldFrame() {
        UIView.animate(withDuration: .zero) {
            self.nicknameTextField.frame = Self.newFrameForNicknameTextField(navBarHeight: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController))
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
    }
    
    func updatePasswordTextFieldFrame() {
        UIView.animate(withDuration: .zero) {
            self.passwordTextField.frame = Self.newFrameForPasswordTextField(navBarHeight: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController))
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
    }
    
    func updateLoginButtonFrame() {
        UIView.animate(withDuration: .zero) {
            self.loginButton.frame = Self.newFrameForLoginButton(navBarHeight: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController))
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
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
        nicknameTextField.dropShadow(color: MDAppStyling.Color.md_Shadow_0_Light_Appearence.color(0.5),
                                     offSet: .init(width: 2, height: 4),
                                     radius: 15)
    }
    
    func dropShadowPasswordTextField() {
        passwordTextField.dropShadow(color: MDAppStyling.Color.md_Shadow_0_Light_Appearence.color(0.5),
                                     offSet: .init(width: 2, height: 4),
                                     radius: 15)
    }
    
    func dropShadowLoginButtonView() {
        loginButton.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.7),
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

// MARK: - Hide Keyboard
fileprivate extension AuthenticationViewController {
    
    func hideKeyboardFunc() {
        self.view.endEditing(true)
    }
    
}

// MARK: - New Frame
fileprivate extension AuthenticationViewController {
    
    static func newFrameForNicknameTextField(navBarHeight: CGFloat) -> CGRect {
        return .init(origin: .init(x: nicknameTextFieldLeftOffset,
                                   y: navBarHeight + nicknameTextFieldTopOffset),
                     size: .init(width: MDConstants.Screen.width - (nicknameTextFieldLeftOffset + nicknameTextFieldRightOffset),
                                 height: nicknameTextFieldHeight))
    }
    
    static func newFrameForPasswordTextField(navBarHeight: CGFloat) -> CGRect {
        return .init(origin: .init(x: passwordTextFieldLeftOffset,
                                   y: newFrameForNicknameTextField(navBarHeight: navBarHeight).maxY + passwordTextFieldTopOffset),
                     size: .init(width: MDConstants.Screen.width - (passwordTextFieldLeftOffset + passwordTextFieldRightOffset),
                                 height: passwordTextFieldHeight))
    }
    
    static func newFrameForLoginButton(navBarHeight: CGFloat) -> CGRect {
        return .init(origin: .init(x: loginButtonLeftOffset,
                                   y: newFrameForPasswordTextField(navBarHeight: navBarHeight).maxY + loginButtonTopOffset),
                     size: .init(width: MDConstants.Screen.width - (loginButtonLeftOffset + loginButtonRightOffset),
                                 height: loginButtonHeight))
    }
    
}
