//
//  ChoiceAuthenticationOrRegistrationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 10.09.2021.

import UIKit

final class ChoiceAuthenticationOrRegistrationViewController: UIViewController {
    
    fileprivate let navigationBarHeight: CGFloat = 144
    
    fileprivate let backgroundImageView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
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
        
    }
    
}

// MARK: - Add Constraints
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func addConstraints() {
        
    }
    
}

// MARK: - Configure UI
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true        
        self.navigationController?.setNavigationBarBackgroundImage(MDAppStyling.Image.background_navigation_bar_0.image)
    }
    
}

// MARK: - Actions
fileprivate extension ChoiceAuthenticationOrRegistrationViewController {
    
}
