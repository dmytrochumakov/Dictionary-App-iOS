//
//  CourseListRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

protocol CourseListRouterProtocol {
    
    var presenter: UIViewController? { get set }
    
    func openSettings()
    func showAddCourse()
    func showWordList(withCourse course: CDCourseEntity)
    
}

final class CourseListRouter: CourseListRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension CourseListRouter {
    
    func openSettings() {        
        presenter?.show(SettingsModule.init().module, sender: nil)
    }
    
    func showAddCourse() {
        presenter?.show(AddCourseModule.init().module, sender: nil)
    }
    
    func showWordList(withCourse course: CDCourseEntity) {
        presenter?.show(WordListModule.init(sender: course).module, sender: nil)
    }
    
}
