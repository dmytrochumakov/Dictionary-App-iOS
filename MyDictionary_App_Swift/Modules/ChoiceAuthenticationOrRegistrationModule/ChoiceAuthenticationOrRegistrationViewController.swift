//
//  ChoiceAuthenticationOrRegistrationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

final class ChoiceAuthenticationOrRegistrationViewController: UIViewController {
    
    fileprivate static let defaultNavigationBarViewHeight: CGFloat = 120
    fileprivate let navigationBarView: UIView = {
        let view: UIView = .init(frame: .init(origin: .zero,
                                              size: .init(width: MDConstants.Screen.width,
                                                          height: defaultNavigationBarViewHeight)))
        view.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
        return view
    }()
    
    fileprivate let navigationBarBackgroundImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.background_navigation_bar_0.image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate static let iconNavigationBarImageViewSize: CGSize = .init(width: 189, height: 71)
    fileprivate let iconNavigationBarImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.my_dictionary.image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let backgroundImageView: UIImageView = {
        let imageView: UIImageView = .init(frame: .init(origin: .init(x: .zero,
                                                                      y: defaultNavigationBarViewHeight),
                                                        size: .init(width: MDConstants.Screen.width,
                                                                    height: MDConstants.Screen.height - defaultNavigationBarViewHeight)))
        imageView.image = MDAppStyling.Image.background_typography_0.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    fileprivate static let loginButtonHeight: CGFloat = 48
    fileprivate static let loginButtonLeftOffset: CGFloat = 16
    fileprivate static let loginButtonRightOffset: CGFloat = 16
    fileprivate static let loginButtonTopOffset: CGFloat = 24
    fileprivate let loginButton: UIButton = {
        let button: UIButton = .init(frame: .init(origin: .init(x: loginButtonLeftOffset,
                                                                y: defaultNavigationBarViewHeight + loginButtonTopOffset),
                                                  size: .init(width: MDConstants.Screen.width - (loginButtonLeftOffset + loginButtonRightOffset),
                                                              height: loginButtonHeight)))
        
        button.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
        button.setTitle(KeysForTranslate.login.localized, for: .normal)
        button.setTitleColor(MDAppStyling.Color.md_White_0_Light_Appearence.color(), for: .normal)
        button.titleLabel?.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        return button
    }()
    
    fileprivate let presenter: ChoiceAuthenticationOrRegistrationPresenterInputProtocol
    
    init(presenter: ChoiceAuthenticationOrRegistrationPresenterInputProtocol) {
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
        roundOffEdges()
    }
    
}

// MARK: - ChoiceAuthenticationOrRegistrationPresenterOutputProtocol
extension ChoiceAuthenticationOrRegistrationViewController: ChoiceAuthenticationOrRegistrationPresenterOutputProtocol {
    
}

// MARK: - Add Views
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func addViews() {
        addNavigationBarView()
        addBackgroundImageView()
        addNavigationBarBackgroundImageView()
        addIconNavigationBarImageView()
        addLoginButton()
    }
    
    func addNavigationBarView() {
        view.addSubview(navigationBarView)
    }
    
    func addBackgroundImageView() {
        view.addSubview(backgroundImageView)
    }
    
    func addNavigationBarBackgroundImageView() {
        view.addSubview(navigationBarBackgroundImageView)
    }
    
    func addIconNavigationBarImageView() {
        view.addSubview(iconNavigationBarImageView)
    }
    
    func addLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func addConstraints() {
        addNavigationBarBackgroundImageViewConstraints()
        addIconNavigationBarImageViewConstraints()
    }
    
    func addNavigationBarBackgroundImageViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.navigationBarBackgroundImageView,
                                                         toItem: self.navigationBarView)
        
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
        hideNavigationBar()
        updateFrame()
        dropShadow()
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

// MARK: - Drop Shadow
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func dropShadow() {
        dropShadowNavigationBarView()
        dropShadowLoginButtonView()
    }
    
    func dropShadowNavigationBarView() {
        navigationBarView.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.7),
                                     offSet: .init(width: 0,
                                                   height: 4),
                                     radius: 20)
    }
    
    func dropShadowLoginButtonView() {
        loginButton.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.7),
                               offSet: .init(width: 0,
                                             height: 4),
                               radius: 20)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func roundOffEdges() {
        loginButtonRoundOffEdges()
    }
    
    func loginButtonRoundOffEdges() {
        loginButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Update Frame
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func updateFrame() {
        updateInternalNavigationBarFrame()
        updateBackgroundImageViewFrame()
        updateLoginButtonFrame()
    }
    
    func updateInternalNavigationBarFrame() {
        
        let newFrame: CGRect = .init(origin: self.navigationBarView.frame.origin,
                                     size: .init(width: self.navigationBarView.bounds.width,
                                                 height: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController)))
        
        UIView.animate(withDuration: .zero) {
            self.navigationBarView.frame = newFrame
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
        
    }
    
    func updateBackgroundImageViewFrame() {
        
        let navBarHeight: CGFloat = MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController)
        
        let newFrame: CGRect = .init(origin: .init(x: .zero,
                                                   y: navBarHeight),
                                     size: .init(width: self.backgroundImageView.bounds.width,
                                                 height: MDConstants.Screen.height - navBarHeight))
        
        UIView.animate(withDuration: .zero) {
            self.backgroundImageView.frame = newFrame
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
        
    }
    
    func updateLoginButtonFrame() {
        
        let navBarHeight: CGFloat = MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController)
        
        let newFrame: CGRect = .init(origin: .init(x: Self.loginButtonLeftOffset,
                                                   y: navBarHeight + Self.loginButtonTopOffset),
                                     size: .init(width: MDConstants.Screen.width - (Self.loginButtonLeftOffset + Self.loginButtonRightOffset),
                                                 height: Self.loginButtonHeight))
        
        UIView.animate(withDuration: .zero) {
            self.loginButton.frame = newFrame
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
        
    }
    
}

// MARK: - Actions
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    @objc func loginButtonAction() {
        debugPrint(#function, Self.self)
    }
    
}
