//
//  AppearanceViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

final class AppearanceViewController: UIViewController {

    let presenter: AppearancePresenterInputProtocol

    init(presenter: AppearancePresenterInputProtocol) {
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

// MARK: - AppearancePresenterOutputProtocol
extension AppearanceViewController: AppearancePresenterOutputProtocol {
       
}

// MARK: - Configure UI
fileprivate extension AppearanceViewController {
    
    func configureUI() {
        configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = AppStyling.Color.systemWhite.color()
        self.title = KeysForTranslate.appearance.localized
    }

}
