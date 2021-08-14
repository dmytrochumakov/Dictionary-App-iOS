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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}

// MARK: - RegistrationPresenterOutputProtocol
extension RegistrationViewController: RegistrationPresenterOutputProtocol {
       
}
