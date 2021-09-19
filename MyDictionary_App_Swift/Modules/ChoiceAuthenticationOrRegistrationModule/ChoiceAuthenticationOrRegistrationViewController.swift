//
//  ChoiceAuthenticationOrRegistrationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

final class ChoiceAuthenticationOrRegistrationViewController: MDBaseNavigationBarAndBackgroundImageViewController {
    
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
        let button: UIButton = .init()
        button.backgroundColor = MDAppStyling.Color.md_Blue_4400D4_Light_Appearence.color()
        button.setTitle(KeysForTranslate.login.localized, for: .normal)
        button.setTitleColor(MDAppStyling.Color.md_White_FFFFFF_Light_Appearence.color(), for: .normal)
        button.titleLabel?.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate static let registrationButtonHeight: CGFloat = 48
    fileprivate static let registrationButtonLeftOffset: CGFloat = 16
    fileprivate static let registrationButtonRightOffset: CGFloat = 16
    fileprivate static let registrationButtonTopOffset: CGFloat = 16
    fileprivate let registrationButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDAppStyling.Color.md_Blue_4400D4_Light_Appearence.color()
        button.setTitle(KeysForTranslate.registration.localized, for: .normal)
        button.setTitleColor(MDAppStyling.Color.md_White_FFFFFF_Light_Appearence.color(), for: .normal)
        button.titleLabel?.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let presenter: ChoiceAuthenticationOrRegistrationPresenterInputProtocol
    
    init(presenter: ChoiceAuthenticationOrRegistrationPresenterInputProtocol) {
        self.presenter = presenter
        super.init(navigationBarBackgroundImage: MDAppStyling.Image.background_navigation_bar_0.image,
                   backgroundImage: MDAppStyling.Image.background_typography_0.image)
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
        addLoginButtonConstraints()
        addRegistrationButtonConstraints()
    }
    
    func addIconNavigationBarImageViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.iconNavigationBarImageView,
                                              attribute: .left,
                                              toItem: self.navigationBarView,
                                              attribute: .left,
                                              constant: 20)
        
        NSLayoutConstraint.addEqualConstraint(item: self.iconNavigationBarImageView,
                                              attribute: .bottom,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: -8)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.iconNavigationBarImageView,
                                                    constant: Self.iconNavigationBarImageViewSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.iconNavigationBarImageView,
                                                   constant: Self.iconNavigationBarImageViewSize.width)
        
    }
    
    func addLoginButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.loginButton,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
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
    
    func addRegistrationButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.registrationButton,
                                              attribute: .top,
                                              toItem: self.loginButton,
                                              attribute: .bottom,
                                              constant: Self.registrationButtonTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.registrationButton,
                                                  toItem: self.backgroundImageView,
                                                  constant: Self.registrationButtonLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.registrationButton,
                                                   toItem: self.backgroundImageView,
                                                   constant: -Self.registrationButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.registrationButton,
                                                    constant: Self.registrationButtonHeight)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        updateLayoutSubviews()
    }
    
    func updateLayoutSubviews() {
        DispatchQueue.main.async {
            self.viewDidLayoutSubviews()
        }
    }
    
}

// MARK: - Drop Shadow
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func dropShadow() {
        dropShadowLoginButtonView()
        dropShadowRegistrationButton()
    }
    
    func dropShadowLoginButtonView() {
        loginButton.dropShadow(color: MDAppStyling.Color.md_Blue_4400D4_Light_Appearence.color(0.5),
                               offSet: .init(width: 0,
                                             height: 4),
                               radius: 20)
    }
    
    func dropShadowRegistrationButton() {
        registrationButton.dropShadow(color: MDAppStyling.Color.md_Blue_4400D4_Light_Appearence.color(0.5),
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

// MARK: - Actions
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    @objc func loginButtonAction() {
        presenter.loginButtonClicked()
    }
    
    @objc func registrationButtonAction() {
        presenter.registrationButtonClicked()
    }
    
}
