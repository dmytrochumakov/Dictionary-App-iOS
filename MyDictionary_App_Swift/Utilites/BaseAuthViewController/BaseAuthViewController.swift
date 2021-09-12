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
        let view: UIView = .init(frame: newFrameForNavigationBarView(size: .init(width: MDConstants.Screen.width,
                                                                                 height: defaultNavigationBarViewHeight)))
        view.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
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
        let imageView: UIImageView = .init(frame: newFrameForBackgroundImageView(navBarHeight: defaultNavigationBarViewHeight,
                                                                                 width: MDConstants.Screen.width))
        imageView.image = MDAppStyling.Image.background_typography_0.image
        imageView.contentMode = .scaleAspectFill
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
    
    func addNavigationBarBackgroundImageViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.navigationBarBackgroundImageView,
                                                         toItem: self.navigationBarView)
        
    }
    
}

// MARK: - Update Frame
extension BaseAuthViewController {
    
    func updateInternalNavigationBarFrame() {
        
        UIView.animate(withDuration: .zero) {
            self.navigationBarView.frame = Self.newFrameForNavigationBarView(size: .init(width: self.navigationBarView.bounds.width,
                                                                                         height: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController)))
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
        
    }
    
    func updateBackgroundImageViewFrame() {
        
        UIView.animate(withDuration: .zero) {
            self.backgroundImageView.frame = Self.newFrameForBackgroundImageView(navBarHeight: MDConstants.NavigationBar.heightPlusStatusBarHeight(fromNavigationController: self.navigationController),
                                                                                 width: self.backgroundImageView.bounds.width)
            self.view.layoutSubviews()
            self.viewDidLayoutSubviews()
        }
        
    }
    
}

// MARK: - New Frame
extension BaseAuthViewController {
    
    static func newFrameForNavigationBarView(size: CGSize) -> CGRect {
        return .init(origin: .zero,
                     size: .init(width: size.width,
                                 height: size.height))
    }
    
    static func newFrameForBackgroundImageView(navBarHeight: CGFloat,
                                               width: CGFloat) -> CGRect {
        return .init(origin: .init(x: .zero,
                                   y: navBarHeight),
                     size: .init(width: width,
                                 height: MDConstants.Screen.height - navBarHeight))
    }
    
}

// MARK: - Drop Shadow
extension BaseAuthViewController {
    
    func dropShadowNavigationBarView() {
        navigationBarView.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.7),
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
        addNavigationBarBackgroundImageViewConstraints()
    }
    
}

// MARK: - Configure UI
fileprivate extension BaseAuthViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        hideNavigationBar()
        updateFrame()
        dropShadow()
    }
    
}

// MARK: - Drop Shadow
fileprivate extension BaseAuthViewController {
    
    func dropShadow() {
        dropShadowNavigationBarView()
    }
    
}

// MARK: - Update Frame
fileprivate extension BaseAuthViewController {
    
    func updateFrame() {
        updateInternalNavigationBarFrame()
        updateBackgroundImageViewFrame()
    }
    
}
