//
//  SettingsViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

final class SettingsViewController: UIViewController {

    fileprivate let presenter: SettingsPresenterInputProtocol

    init(presenter: SettingsPresenterInputProtocol) {
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

// MARK: - SettingsPresenterOutputProtocol
extension SettingsViewController: SettingsPresenterOutputProtocol {
       
}

// MARK: - Configure UI
fileprivate extension SettingsViewController {
    
    func configureUI() {
        configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = AppStyling.Color.systemWhite.color()
        self.title = KeysForTranslate.settings.localized
    }

}
