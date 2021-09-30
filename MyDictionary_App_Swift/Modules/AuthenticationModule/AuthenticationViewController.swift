//
//  AuthenticationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import MBProgressHUD

final class AuthenticationViewController: MDBaseLargeTitledBackViewControllerWithBackgroundImage {
    
    fileprivate let presenter: AuthenticationPresenterInputProtocol
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var keyboardHandler: KeyboardHandler!
    
    fileprivate static let nicknameTextFieldHeight: CGFloat = 48
    fileprivate static let nicknameTextFieldTopOffset: CGFloat = 24
    fileprivate static let nicknameTextFieldLeftOffset: CGFloat = 16
    fileprivate static let nicknameTextFieldRightOffset: CGFloat = 16
    fileprivate let nicknameTextField: MDTextFieldWithToolBar = {
        let textField: MDTextFieldWithToolBar = .init(rectInset: MDConstants.Rect.defaultInset,
                                                      keyboardToolbar: .init())
        textField.placeholder = MDLocalizedText.nickname.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.font = MDUIResources.Font.MyriadProItalic.font()
        textField.textColor = MDUIResources.Color.md_3C3C3C.color()
        textField.returnKeyType = .next
        textField.tag = AuthenticationTextFieldTag.nickname.rawValue
        textField.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
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
        textField.placeholder = MDLocalizedText.password.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.font = MDUIResources.Font.MyriadProItalic.font()
        textField.textColor = MDUIResources.Color.md_3C3C3C.color()
        textField.returnKeyType = .go
        textField.isSecureTextEntry = true
        textField.tag = AuthenticationTextFieldTag.password.rawValue
        textField.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate static let loginButtonHeight: CGFloat = 48
    fileprivate static let loginButtonTopOffset: CGFloat = 16
    fileprivate static let loginButtonLeftOffset: CGFloat = 16
    fileprivate static let loginButtonRightOffset: CGFloat = 16
    fileprivate let loginButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_4400D4.color()
        button.setTitle(MDLocalizedText.login.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var hud: MBProgressHUD = {
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .annularDeterminate
        hud.label.text = MDLocalizedText.pleaseWaitForDataSync.localized
        hud.label.font = MDUIResources.Font.MyriadProRegular.font()
        hud.label.textColor = MDUIResources.Color.md_3C3C3C.color()
        return hud
    }()
    
    init(presenter: AuthenticationPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: MDLocalizedText.login.localized,
                   navigationBarBackgroundImage: MDUIResources.Image.background_navigation_bar_0.image,
                   backgroundImage: MDUIResources.Image.background_typography_1.image)
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
    
    func showError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: MDLocalizedText.error.localized,
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
        addScrollView()
        addContentView()
        bringSubviewsToFront()
        addNicknameTextField()
        addPasswordTextField()
        addLoginButton()
    }
    
    func bringSubviewsToFront() {
        view.bringSubviewToFront(navigationBarView)
        view.bringSubviewToFront(navigationBarBackgroundImageView)
        view.bringSubviewToFront(backButton)
        view.bringSubviewToFront(titleLabel)
    }
    
    func addScrollView() {
        view.addSubview(scrollView)
    }
    
    func addContentView() {
        scrollView.addSubview(contentView)
    }
    
    func addNicknameTextField() {
        nicknameTextField.delegate = presenter.textFieldDelegate
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingDidChangeAction), for: .editingChanged)
        contentView.addSubview(nicknameTextField)
    }
    
    func addPasswordTextField() {
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingDidChangeAction), for: .editingChanged)
        passwordTextField.delegate = presenter.textFieldDelegate
        contentView.addSubview(passwordTextField)
    }
    
    func addLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        contentView.addSubview(loginButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AuthenticationViewController {
    
    func addConstraints() {
        addScrollViewConstraints()
        addContentViewConstraints()
        addNicknameTextFieldConstraints()
        addPasswordTextFieldConstraints()
        addLoginButtonConstraints()
    }
    
    func addScrollViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.scrollView,
                                                         toItem: self.view)
        
    }
    
    func addContentViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.contentView,
                                                         toItem: self.scrollView)
        
        NSLayoutConstraint.addEqualCenterXConstraint(item: self.contentView,
                                                     toItem: self.scrollView,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.contentView,
                                                     toItem: self.scrollView,
                                                     constant: .zero)
        
    }
    
    func addNicknameTextFieldConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.nicknameTextField,
                                              attribute: .top,
                                              toItem: self.contentView,
                                              attribute: .top,
                                              constant: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: navigationController,
                                                                                                            prefersLargeTitles: true) + Self.nicknameTextFieldTopOffset)
        
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
        configureSelfView()
        createKeyboardHandler()
    }
    
    func configureSelfView() {
        self.view.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
    }
    
    func createKeyboardHandler() {
        self.keyboardHandler = KeyboardHandler.createKeyboardHandler(scrollView: self.scrollView)
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
        nicknameTextField.dropShadow(color: MDUIResources.Color.md_5200FF.color(0.5),
                                     offSet: .init(width: 2, height: 4),
                                     radius: 15)
    }
    
    func dropShadowPasswordTextField() {
        passwordTextField.dropShadow(color: MDUIResources.Color.md_5200FF.color(0.5),
                                     offSet: .init(width: 2, height: 4),
                                     radius: 15)
    }
    
    func dropShadowLoginButtonView() {
        loginButton.dropShadow(color: MDUIResources.Color.md_4400D4.color(0.5),
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
