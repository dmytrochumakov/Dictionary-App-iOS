//
//  EditWordRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

protocol EditWordRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class EditWordRouter: EditWordRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
