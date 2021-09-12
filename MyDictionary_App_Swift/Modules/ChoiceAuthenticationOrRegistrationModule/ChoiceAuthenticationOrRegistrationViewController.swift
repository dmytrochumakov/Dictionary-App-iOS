//
//  ChoiceAuthenticationOrRegistrationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

final class ChoiceAuthenticationOrRegistrationViewController: BaseAuthViewController {
    
    fileprivate static let iconNavigationBarImageViewSize: CGSize = .init(width: 189, height: 71)
    fileprivate let iconNavigationBarImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.my_dictionary.image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()        
    
    fileprivate static let loginButtonHeight: CGFloat = 48
    fileprivate static let loginButtonLeftOffset: CGFloat = 16
    fileprivate static let loginButtonRightOffset: CGFloat = 16
    fileprivate static let loginButtonTopOffset: CGFloat = 24
    fileprivate let loginButton: UIButton = {
        let button: UIButton = .init(frame: newFrameForLoginButton(navBarHeight: defaultNavigationBarViewHeight))
        button.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
        button.setTitle(KeysForTranslate.login.localized, for: .normal)
        button.setTitleColor(MDAppStyling.Color.md_White_0_Light_Appearence.color(), for: .normal)
        button.titleLabel?.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        return button
    }()
    
    fileprivate static let registrationButtonHeight: CGFloat = 48
    fileprivate static let registrationButtonLeftOffset: CGFloat = 16
    fileprivate static let registrationButtonRightOffset: CGFloat = 16
    fileprivate static let registrationButtonTopOffset: CGFloat = 16
    fileprivate let registrationButton: UIButton = {
        let button: UIButton = .init(frame: newFrameForRegistrationButton(navBarHeight: defaultNavigationBarViewHeight))
        button.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
        button.setTitle(KeysForTranslate.registration.localized, for: .normal)
        button.setTitleColor(MDAppStyling.Color.md_White_0_Light_Appearence.color(), for: .normal)
        button.titleLabel?.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        return button
    }()
    
    fileprivate let presenter: ChoiceAuthenticationOrRegistrationPresenterInputProtocol
    
    init(presenter: ChoiceAuthenticationOrRegistrationPresenterInputProtocol) {
        self.presenter = presenter
        super.init()
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
    }
    
}

// MARK: - ChoiceAuthenticationOrRegistrationPresenterOutputProtocol
extension ChoiceAuthenticationOrRegistrationViewController: ChoiceAuthenticationOrRegistrationPresenterOutputProtocol {
    
}

// MARK: - Add Views
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func addViews() {
        addIconNavigationBarImageView()
        addLoginButton()
        addRegistrationButton()
    }        
    
    func addIconNavigationBarImageView() {
        view.addSubview(iconNavigationBarImageView)
    }
    
    func addLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    func addRegistrationButton() {
        registrationButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        view.addSubview(registrationButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func addConstraints() {
        addIconNavigationBarImageViewConstraints()
    }
    
    func addIconNavigationBarImageViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraintAndActivate(item: self.iconNavigationBarImageView,
                                                         attribute: .left,
                                                         toItem: self.navigationBarView,
                                                         attribute: .left,
                                                         constant: 20)
        
        NSLayoutConstraint.addEqualConstraintAndActivate(item: self.iconNavigationBarImageView,
                                                         attribute: .bottom,
                                                         toItem: self.navigationBarView,
                                                         attribute: .bottom,
                                                         constant: -8)
        
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: self.iconNavigationBarImageView,
                                                               constant: Self.iconNavigationBarImageViewSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraintAndActivate(item: self.iconNavigationBarImageView,
                                                              constant: Self.iconNavigationBarImageViewSize.width)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        updateFrame()
        dropShadow()
    }
    
}

// MARK: - Drop Shadow
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func dropShadow() {
        dropShadowLoginButtonView()
        dropShadowRegistrationButton()
    }
    
    func dropShadowLoginButtonView() {
        loginButton.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.7),
                               offSet: .init(width: 0,
                                             height: 4),
                               radius: 20)
    }
    
    func dropShadowRegistrationButton() {
        registrationButton.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.7),
                                      offSet: .init(width: 0,
                                                    height: 4),
                                      radius: 20)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func roundOffEdges() {
        loginButtonRoundOffEdges()
        registrationButtonRoundOffEdges()
    }
    
    func loginButtonRoundOffEdges() {
        loginButton.layer.cornerRadius = 10
    }
    
    func registrationButtonRoundOffEdges() {
        registrationButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Update Frame
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func updateFrame() {
        updateLoginButtonFrame()
        updateRegistrationButtonFrame()
    }
    
    func updateLoginButtonFrame() {
        
        UIView.animate(withDuration: .zero) {
            self.loginButton.frame = Self.newFrameForLoginButton(navBarHeight: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController))
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
        
    }
    
    func updateRegistrationButtonFrame() {
        
        UIView.animate(withDuration: .zero) {
            self.registrationButton.frame = Self.newFrameForRegistrationButton(navBarHeight: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController))
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
        
    }
    
}

// MARK: - New Frame
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    static func newFrameForLoginButton(navBarHeight: CGFloat) -> CGRect {
        return .init(origin: .init(x: Self.loginButtonLeftOffset,
                                   y: navBarHeight + Self.loginButtonTopOffset),
                     size: .init(width: MDConstants.Screen.width - (Self.loginButtonLeftOffset + Self.loginButtonRightOffset),
                                 height: Self.loginButtonHeight))
    }
    
    static func newFrameForRegistrationButton(navBarHeight: CGFloat) -> CGRect {
        return .init(origin: .init(x: registrationButtonLeftOffset,
                                   y: navBarHeight +
                                    loginButtonTopOffset +
                                    loginButtonHeight +
                                    registrationButtonTopOffset),
                     size: .init(width: MDConstants.Screen.width - (registrationButtonLeftOffset + registrationButtonRightOffset),
                                 height: registrationButtonHeight))
    }
    
}

// MARK: - Actions
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    @objc func loginButtonAction() {
        presenter.loginButtonClicked()
    }
    
    @objc func registrationButtonAction() {
        presenter.registrationButtonClicked()
    }
    
}
