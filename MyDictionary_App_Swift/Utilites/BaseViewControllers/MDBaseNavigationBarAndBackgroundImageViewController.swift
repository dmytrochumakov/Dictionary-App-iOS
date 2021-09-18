//
//  MDBaseNavigationBarAndBackgroundImageViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 12.09.2021.
//

import UIKit

open class MDBaseNavigationBarAndBackgroundImageViewController: MDBaseNavigationBarViewController {
    
    internal let backgroundImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.background_typography_0.image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init() {
        super.init()
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
extension MDBaseNavigationBarAndBackgroundImageViewController {
        
    func addBackgroundImageView() {
        view.addSubview(backgroundImageView)
    }
    
}

// MARK: - Add Constraint
extension MDBaseNavigationBarAndBackgroundImageViewController {
        
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
        
}

// MARK: - Update Background Image
extension MDBaseNavigationBarAndBackgroundImageViewController {
    
    func updateBackgroundImage(_ newImage: UIImage) {
        backgroundImageView.image = newImage
    }
    
}

// MARK: - Add Views
fileprivate extension MDBaseNavigationBarAndBackgroundImageViewController {
    
    func addViews() {
        addNavigationBarView()
        addBackgroundImageView()
        addNavigationBarBackgroundImageView()
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseNavigationBarAndBackgroundImageViewController {
    
    func addConstraints() {
        addNavigationBarViewConstraints()
        addBackgroundImageViewConstraints()
        addNavigationBarBackgroundImageViewConstraints()
    }
    
}

// MARK: - Configure UI
fileprivate extension MDBaseNavigationBarAndBackgroundImageViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        setupNavigationBar()
    }
    
}

// MARK: - Drop Shadow
fileprivate extension MDBaseNavigationBarAndBackgroundImageViewController {
    
    func dropShadow() {
        dropShadowNavigationBarView()
    }
    
}
