//
//  CourseListRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class CourseListRouter: CourseListRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
