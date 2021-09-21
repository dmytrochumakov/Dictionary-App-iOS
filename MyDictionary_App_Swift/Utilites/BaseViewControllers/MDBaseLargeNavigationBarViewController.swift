//
//  MDBaseLargeNavigationBarViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

open class MDBaseLargeNavigationBarViewController: MDBaseNavigationBarViewController {
    
    override init(navigationBarBackgroundImage: UIImage) {
        super.init(navigationBarBackgroundImage: navigationBarBackgroundImage)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationBarPrefersLargeTitlesTrue()
    }
    
}

extension MDBaseLargeNavigationBarViewController {
    
    func navigationBarPrefersLargeTitlesTrue() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
