//
//  WordListRouter.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

protocol WordListRouterProtocol {
    var wordListViewController: UIViewController! { get set }
    func showAddWord(withCourse course: CourseResponse)
    func showEditWord(withWord word: MDWordModel)
}

final class WordListRouter: WordListRouterProtocol {
    
    internal weak var wordListViewController: UIViewController!
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension WordListRouter {
    
    func showAddWord(withCourse course: CourseResponse) {
        wordListViewController?.show(AddWordModule.init(sender: course).module, sender: nil)
    }
    
    func showEditWord(withWord word: MDWordModel) {
        wordListViewController?.show(EditWordModule.init(sender: word).module, sender: nil)
    }
    
}
