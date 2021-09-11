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
    
    fileprivate let backgroundImageView: UIImageView = {
        let imageView: UIImageView = .init(frame: .init(origin: .init(x: .zero,
                                                                      y: defaultNavigationBarViewHeight),
                                                        size: .init(width: MDConstants.Screen.width,
                                                                    height: MDConstants.Screen.height - defaultNavigationBarViewHeight)))
        imageView.image = MDAppStyling.Image.background_typography_0.image
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
}

// MARK: - Add Constraints
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func addConstraints() {
        addNavigationBarBackgroundImageViewConstraints()
    }
    
    func addNavigationBarBackgroundImageViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.navigationBarBackgroundImageView,
                                                         toItem: self.navigationBarView)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        hideNavigationBar()
        updateInternalNavigationBarFrame()
        updateBackgroundImageViewFrame()
        dropShadowNavigationBarView()
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func dropShadowNavigationBarView() {
        navigationBarView.dropShadow(color: MDAppStyling.Color.md_Shadow_0_Light_Appearence.color(0.7),
                                     offSet: .init(width: 0,
                                                   height: 4),
                                     radius: 20)
    }
    
}

// MARK: - Update UI
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
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
    
}

// MARK: - Actions
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
}
