//
//  SelectCourseRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol SelectCourseRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class SelectCourseRouter: SelectCourseRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
