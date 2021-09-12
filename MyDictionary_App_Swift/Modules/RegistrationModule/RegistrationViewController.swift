//
//  RegistrationViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

final class RegistrationViewController: UIViewController {
    
    fileprivate let presenter: RegistrationPresenterInputProtocol
    
    init(presenter: RegistrationPresenterInputProtocol) {
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

// MARK: - RegistrationPresenterOutputProtocol
extension RegistrationViewController: RegistrationPresenterOutputProtocol {
    
    func makePasswordFieldActive() {
        
    }
    
    func hideKeyboard() {
        self.hideKeyboardFunc()
    }
    
    func showValidationError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: KeysForTranslate.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
}

// MARK: - Add Views
fileprivate extension RegistrationViewController {
    
    func addViews() {
        
    }
    
}

// MARK: - Add Constraints
fileprivate extension RegistrationViewController {
    
    func addConstraints() {
        
    }
    
}

// MARK: - Configure UI
fileprivate extension RegistrationViewController {
    
    func configureUI() {
        configureAppearance(fromAppearanceType: Appearance.current.appearanceType)
    }
    
}

// MARK: - Actions
fileprivate extension RegistrationViewController {
    
}

// MARK: - Hide Keyboard
fileprivate extension RegistrationViewController {
    
    func hideKeyboardFunc() {
        self.view.endEditing(true)
    }
    
}
