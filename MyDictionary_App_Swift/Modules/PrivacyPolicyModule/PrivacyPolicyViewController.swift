//
//  PrivacyPolicyViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

final class PrivacyPolicyViewController: UIViewController {

    fileprivate let presenter: PrivacyPolicyPresenterInputProtocol

    init(presenter: PrivacyPolicyPresenterInputProtocol) {
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

// MARK: - PrivacyPolicyPresenterOutputProtocol
extension PrivacyPolicyViewController: PrivacyPolicyPresenterOutputProtocol {
       
}
