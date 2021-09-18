//
//  MDBaseNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

open class MDBaseNavigationBarViewController: UIViewController {
    
    internal let navigationBarView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = MDAppStyling.Color.md_Blue_1_Light_Appearence.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let navigationBarBackgroundImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(navigationBarBackgroundImage: UIImage) {
        navigationBarBackgroundImageView.image = navigationBarBackgroundImage
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
extension MDBaseNavigationBarViewController {
    
    func addNavigationBarView() {
        view.addSubview(navigationBarView)
    }
    
    func addNavigationBarBackgroundImageView() {
        view.addSubview(navigationBarBackgroundImageView)
    }
    
}

// MARK: - Add Constraint
extension MDBaseNavigationBarViewController {
    
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
    
    func addNavigationBarBackgroundImageViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.navigationBarBackgroundImageView,
                                                         toItem: self.navigationBarView)
        
    }
    
}

// MARK: - Drop Shadow
extension MDBaseNavigationBarViewController {
    
    func dropShadowNavigationBarView() {
        navigationBarView.dropShadow(color: MDAppStyling.Color.md_Blue_1_Light_Appearence.color(0.5),
                                     offSet: .init(width: 0,
                                                   height: 4),
                                     radius: 20)
    }
    
}

// MARK: - Setup Navigation Bar
extension MDBaseNavigationBarViewController {
    
    func setupNavigationBar() {
        navigationBarPrefersLargeTitles()
        hideNavigationBar()
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func navigationBarPrefersLargeTitles() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

// MARK: - Add Views
fileprivate extension MDBaseNavigationBarViewController {
    
    func addViews() {
        addNavigationBarView()
        addNavigationBarBackgroundImageView()
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseNavigationBarViewController {
    
    func addConstraints() {
        addNavigationBarViewConstraints()
        addNavigationBarBackgroundImageViewConstraints()
    }
    
}

// MARK: - Configure UI
fileprivate extension MDBaseNavigationBarViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        setupNavigationBar()
    }
    
}

// MARK: - Drop Shadow
fileprivate extension MDBaseNavigationBarViewController {
    
    func dropShadow() {
        dropShadowNavigationBarView()
    }
    
}
