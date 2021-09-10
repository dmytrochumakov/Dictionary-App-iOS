//
//  MDNavigationController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.09.2021.
//

import UIKit

final class MDNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure UI
fileprivate extension MDNavigationController {
    
    func configureUI() {
        hideNavigationBar()
    }
    
    func hideNavigationBar() {
        self.navigationBar.isHidden = true
    }
    
}
