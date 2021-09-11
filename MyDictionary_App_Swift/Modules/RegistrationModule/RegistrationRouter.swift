//
//  RegistrationRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 14.08.2021.

import UIKit

protocol RegistrationRouterProtocol {
    var presenter: UIViewController? { get set }
    func showCourseList()
}

final class RegistrationRouter: RegistrationRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension RegistrationRouter {
    
    func showCourseList() {
        MDConstants.AppDependencies.dependencies.rootWindow.rootViewController = UINavigationController.init(rootViewController: CourseListModule.init(sender: nil).module)
    }
    
}
