//
//  WordListRouter.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

protocol WordListRouterProtocol {
    var wordListViewController: UIViewController! { get set }
    func showAddWord()
}

final class WordListRouter: WordListRouterProtocol {
    
    internal weak var wordListViewController: UIViewController!    
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension WordListRouter {
    
    func showAddWord() {
        wordListViewController?.show(AddWordModule.init(sender: nil).module, sender: nil)
    }
    
}
