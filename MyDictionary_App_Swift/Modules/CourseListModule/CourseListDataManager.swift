//
//  CourseListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataManagerInputProtocol {
    func readAndAddCoursesToDataProvider(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
}

protocol CourseListDataManagerOutputProtocol: AnyObject {
    
}

protocol CourseListDataManagerProtocol: CourseListDataManagerInputProtocol {
    var dataProvider: CourseListDataProviderProtocol { get }
    var dataManagerOutput: CourseListDataManagerOutputProtocol? { get set }
}

final class CourseListDataManager: CourseListDataManagerProtocol {
    
    fileprivate let testData: [CourseResponse] = [.init(userId: 1,
                                                        courseId: 1,
                                                        languageId: 1,
                                                        languageName: "English",
                                                        createdAt: "2021-08-15T10:34:33.998Z"),
                                                  .init(userId: 1,
                                                        courseId: 2,
                                                        languageId: 2,
                                                        languageName: "Spanish",
                                                        createdAt: "2021-08-15T10:34:33.998Z")
    ]
    
    fileprivate let memoryStorage: MDCourseMemoryStorageProtocol
    internal var dataProvider: CourseListDataProviderProtocol
    internal weak var dataManagerOutput: CourseListDataManagerOutputProtocol?
    
    init(memoryStorage: MDCourseMemoryStorageProtocol,
         dataProvider: CourseListDataProviderProtocol) {
        
        self.memoryStorage = memoryStorage
        self.dataProvider = dataProvider
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CourseListDataManagerInputProtocol
extension CourseListDataManager {
    
    func readAndAddCoursesToDataProvider(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        memoryStorage.readAllCourses { [weak self] readResult in
            
            switch readResult {
            
            case .success(let readCourses):
                self?.dataProvider.courses = self?.testData ?? []
                completionHandler(.success(()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
}
