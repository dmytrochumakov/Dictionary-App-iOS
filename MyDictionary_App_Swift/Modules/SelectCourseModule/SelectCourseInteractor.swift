//
//  SelectCourseInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

protocol SelectCourseInteractorInputProtocol {
    
}

protocol SelectCourseInteractorOutputProtocol: AnyObject {
    
}

protocol SelectCourseInteractorProtocol: SelectCourseInteractorInputProtocol,
                                         SelectCourseDataManagerOutputProtocol {
    var interactorOutput: SelectCourseInteractorOutputProtocol? { get set }
}

final class SelectCourseInteractor: SelectCourseInteractorProtocol {

    fileprivate let dataManager: SelectCourseDataManagerInputProtocol
    internal weak var interactorOutput: SelectCourseInteractorOutputProtocol?
    
    init(dataManager: SelectCourseDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - SelectCourseDataManagerOutputProtocol
extension SelectCourseInteractor {
    
}
