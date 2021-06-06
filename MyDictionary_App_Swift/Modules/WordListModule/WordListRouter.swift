//
//  WordListRouter.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

protocol WordListRouterProtocol {
    var wordListViewController: UIViewController! { get set }
}

final class WordListRouter: WordListRouterProtocol {
    
    internal weak var wordListViewController: UIViewController!    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
