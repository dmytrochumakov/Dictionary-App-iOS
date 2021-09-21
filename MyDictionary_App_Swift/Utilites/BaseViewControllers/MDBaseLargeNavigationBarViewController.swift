//
//  MDBaseLargeNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

open class MDBaseLargeNavigationBarViewController: MDBaseNavigationBarViewController {
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationBarPrefersLargeTitles()
    }
    
}

extension MDBaseLargeNavigationBarViewController {
    
    func navigationBarPrefersLargeTitles() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
