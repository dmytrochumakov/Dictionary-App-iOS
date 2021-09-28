//
//  EditWordViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

final class EditWordViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: EditWordPresenterInputProtocol
    
    init(presenter: EditWordPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: presenter.getWordText,
                   navigationBarBackgroundImage: MDUIResources.Image.background_navigation_bar_1.image)
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

// MARK: - EditWordPresenterOutputProtocol
extension EditWordViewController: EditWordPresenterOutputProtocol {
    
}
