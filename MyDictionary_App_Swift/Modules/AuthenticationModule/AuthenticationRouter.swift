//
//  AuthenticationRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 12.08.2021.

import UIKit

protocol AuthenticationRouterProtocol {
    var presenter: UIViewController? { get set }
    func showCourseList()
    func showRegistration()
}

final class AuthenticationRouter: AuthenticationRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AuthenticationRouter {
    
    func showCourseList() {        
        MDConstants.AppDependencies.dependencies.rootWindow.rootViewController = UINavigationController.init(rootViewController: CourseListModule.init().module)
    }
    
    func showRegistration() {
        presenter?.show(RegistrationModule.init().module, sender: nil)
    }
    
}

