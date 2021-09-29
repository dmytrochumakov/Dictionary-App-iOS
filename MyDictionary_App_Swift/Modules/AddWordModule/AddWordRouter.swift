//
//  AddWordRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import UIKit

protocol AddWordRouterProtocol: MDCloseModuleProtocol {
    var presenter: UIViewController? { get set }    
}

final class AddWordRouter: AddWordRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AddWordRouter {
    
    func closeModule() {
        presenter?.navigationController?.popViewController(animated: true)
    }
    
}
