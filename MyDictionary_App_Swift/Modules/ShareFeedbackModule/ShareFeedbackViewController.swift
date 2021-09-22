//
//  ShareFeedbackViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 22.09.2021.

import UIKit

final class ShareFeedbackViewController: UIViewController {

    fileprivate let presenter: ShareFeedbackPresenterInputProtocol

    init(presenter: ShareFeedbackPresenterInputProtocol) {
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

// MARK: - ShareFeedbackPresenterOutputProtocol
extension ShareFeedbackViewController: ShareFeedbackPresenterOutputProtocol {
       
}
