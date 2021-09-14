//
//  BaseAuthViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 12.09.2021.
//

import UIKit

open class BaseAuthViewController: UIViewController {
    
    internal static let defaultNavigationBarViewHeight: CGFloat = 120
    internal let navigationBarView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let navigationBarBackgroundImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.background_navigation_bar_0.image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    internal let backgroundImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.background_typography_0.image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        super.loadView()
        addViews()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
        dropShadow()
    }
    
}

// MARK: - Add View
extension BaseAuthViewController {
    
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

// MARK: - Add Constraint
extension BaseAuthViewController {
    
    func addNavigationBarViewConstraints() {
        
        NSLayoutConstraint.addEqualTopConstraint(item: self.navigationBarView,
                                                            toItem: self.view,
                                                            constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.navigationBarView,
                                                             toItem: self.view,
                                                             constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.navigationBarView,
                                                              toItem: self.view,
                                                              constant: .zero)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.navigationBarView,
                                                               constant: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController))
        
    }
    
    func addBackgroundImageViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.backgroundImageView,
                                                         attribute: .top,
                                                         toItem: self.navigationBarView,
                                                         attribute: .bottom,
                                                         constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.backgroundImageView,
                                                             toItem: self.view,
                                                             constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.backgroundImageView,
                                                              toItem: self.view,
                                                              constant: .zero)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.backgroundImageView,
                                                               toItem: self.view,
                                                               constant: .zero)
        
    }
    
    func addNavigationBarBackgroundImageViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.navigationBarBackgroundImageView,
                                                         toItem: self.navigationBarView)
        
    }
    
}

// MARK: - Drop Shadow
extension BaseAuthViewController {
    
    func dropShadowNavigationBarView() {
        navigationBarView.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.5),
                                     offSet: .init(width: 0,
                                                   height: 4),
                                     radius: 20)
    }
    
}

// MARK: - Hide Nav Bar
extension BaseAuthViewController {
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

// MARK: - Update Background Image
extension BaseAuthViewController {
    
    func updateBackgroundImage(_ newImage: UIImage) {
        backgroundImageView.image = newImage
    }
    
}

// MARK: - Add Views
fileprivate extension BaseAuthViewController {
    
    func addViews() {
        addNavigationBarView()
        addBackgroundImageView()
        addNavigationBarBackgroundImageView()
    }
    
}

// MARK: - Add Constraints
fileprivate extension BaseAuthViewController {
    
    func addConstraints() {
        addNavigationBarViewConstraints()
        addBackgroundImageViewConstraints()
        addNavigationBarBackgroundImageViewConstraints()
    }
    
}

// MARK: - Configure UI
fileprivate extension BaseAuthViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        hideNavigationBar()
    }
    
}

// MARK: - Drop Shadow
fileprivate extension BaseAuthViewController {
    
    func dropShadow() {
        dropShadowNavigationBarView()
    }
    
}
