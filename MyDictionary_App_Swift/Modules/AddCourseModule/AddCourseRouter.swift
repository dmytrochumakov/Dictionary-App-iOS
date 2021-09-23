//
//  AddCourseRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol AddCourseRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class AddCourseRouter: AddCourseRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
