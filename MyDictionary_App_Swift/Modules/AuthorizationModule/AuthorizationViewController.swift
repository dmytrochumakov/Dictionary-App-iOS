//
//  AuthorizationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

final class AuthorizationViewController: UIViewController {

    fileprivate let presenter: AuthorizationPresenterInputProtocol

    init(presenter: AuthorizationPresenterInputProtocol) {
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}

// MARK: - AuthorizationPresenterOutputProtocol
extension AuthorizationViewController: AuthorizationPresenterOutputProtocol {
       
}

// MARK: - Configure UI
fileprivate extension AuthorizationViewController {
    
    func configureUI() {
        configureTitle()
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
    }
    
    func configureTitle() {
        self.title = KeysForTranslate.authorization.localized
    }
    
}
