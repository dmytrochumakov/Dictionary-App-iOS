//
//  RegistrationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

final class RegistrationViewController: BaseDetailAuthViewController {
    
    fileprivate let presenter: RegistrationPresenterInputProtocol
    
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
        textField.tag = RegistrationTextFieldTag.nickname.rawValue
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
        textField.returnKeyType = .next
        textField.isSecureTextEntry = true
        textField.tag = RegistrationTextFieldTag.password.rawValue
        textField.backgroundColor = MDAppStyling.Color.md_White_0_Light_Appearence.color()
        return textField
    }()
    
    fileprivate static let confirmPasswordTextFieldHeight: CGFloat = 48
    fileprivate static let confirmPasswordTextFieldTopOffset: CGFloat = 16
    fileprivate static let confirmPasswordTextFieldLeftOffset: CGFloat = 16
    fileprivate static let confirmPasswordTextFieldRightOffset: CGFloat = 16
    fileprivate let confirmPasswordTextField: MDPasswordTextFieldWithToolBar = {
        let textField: MDPasswordTextFieldWithToolBar = .init(frame: newFrameForConfirmPasswordTextField(navBarHeight: defaultNavigationBarViewHeight),
                                                              rectInset: MDConstants.Rect.passwordInset,
                                                              keyboardToolbar: .init())
        textField.placeholder = KeysForTranslate.confirmPassword.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.font = MDAppStyling.Font.MyriadProItalic.font(ofSize: 17)
        textField.textColor = MDAppStyling.Color.md_Black_1_Light_Appearence.color()
        textField.returnKeyType = .go
        textField.isSecureTextEntry = true
        textField.tag = RegistrationTextFieldTag.confirmPassword.rawValue
        textField.backgroundColor = MDAppStyling.Color.md_White_0_Light_Appearence.color()
        return textField
    }()
    
    init(presenter: RegistrationPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: KeysForTranslate.registration.localized)
        updateBackgroundImage(MDAppStyling.Image.background_typography_2.image)
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
        addPasswordTextField()
        addConfirmPasswordTextField()
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
    
    func addConfirmPasswordTextField() {
        confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldEditingDidChangeAction), for: .editingChanged)
        confirmPasswordTextField.delegate = presenter.textFieldDelegate
        view.addSubview(confirmPasswordTextField)
    }
    
}

// MARK: - Configure UI
fileprivate extension RegistrationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        updateFrame()
        dropShadow()
    }
    
}

// MARK: - Update Frame
fileprivate extension RegistrationViewController {
    
    func updateFrame() {
        updateNicknameTextFieldFrame()
        updatePasswordTextFieldFrame()
        updateConfirmPasswordTextFieldFrame()
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
    
    func updateConfirmPasswordTextFieldFrame() {
        UIView.animate(withDuration: .zero) {
            self.confirmPasswordTextField.frame = Self.newFrameForConfirmPasswordTextField(navBarHeight: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController))
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
    }
    
}

// MARK: - Drop Shadow
fileprivate extension RegistrationViewController {
    
    func dropShadow() {
        dropShadowNicknameTextField()
        dropShadowPasswordTextField()
        dropShadowConfirmPasswordTextField()
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
    
    func dropShadowConfirmPasswordTextField() {
        confirmPasswordTextField.dropShadow(color: MDAppStyling.Color.md_Shadow_0_Light_Appearence.color(0.5),
                                            offSet: .init(width: 2, height: 4),
                                            radius: 15)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension RegistrationViewController {
    
    func roundOffEdges() {
        nicknameTextFieldRoundOffEdges()
        passwordTextFieldRoundOffEdges()
        confirmPasswordTextFieldRoundOffEdges()
    }
    
    func nicknameTextFieldRoundOffEdges() {
        nicknameTextField.layer.cornerRadius = 10
    }
    
    func passwordTextFieldRoundOffEdges() {
        passwordTextField.layer.cornerRadius = 10
    }
    
    func confirmPasswordTextFieldRoundOffEdges() {
        confirmPasswordTextField.layer.cornerRadius = 10
    }
    
}

// MARK: - Actions
fileprivate extension RegistrationViewController {
    
    @objc func nicknameTextFieldEditingDidChangeAction() {
        presenter.nicknameTextFieldEditingDidChangeAction(nicknameTextField.text)
    }
    
    @objc func passwordTextFieldEditingDidChangeAction() {
        presenter.passwordTextFieldEditingDidChangeAction(passwordTextField.text)
    }
    
    @objc func confirmPasswordTextFieldEditingDidChangeAction() {
        //        presenter.confirmPasswordTextFieldEditingDidChangeAction(confirmPasswordTextField.text)
    }
    
}

// MARK: - Hide Keyboard
fileprivate extension RegistrationViewController {
    
    func hideKeyboardFunc() {
        self.view.endEditing(true)
    }
    
}

// MARK: - New Frame
fileprivate extension RegistrationViewController {
    
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
    
    static func newFrameForConfirmPasswordTextField(navBarHeight: CGFloat) -> CGRect {
        return .init(origin: .init(x: confirmPasswordTextFieldLeftOffset,
                                   y: newFrameForPasswordTextField(navBarHeight: navBarHeight).maxY + confirmPasswordTextFieldTopOffset),
                     size: .init(width: MDConstants.Screen.width - (confirmPasswordTextFieldLeftOffset + confirmPasswordTextFieldRightOffset),
                                 height: confirmPasswordTextFieldHeight))
    }
    
}
