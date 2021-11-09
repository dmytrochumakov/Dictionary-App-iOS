//
//  CourseListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataManagerInputProtocol {
    
    var dataProvider: CourseListDataProviderProtocol { get }
    
    func addCourse(atNewCourse course: MDCourseListModel) -> IndexPath
    func readAndAddCoursesToDataProvider()
    func filterCourses(_ searchText: String?)
    func clearCourseFilter()
    func deleteCourse(atIndexPath indexPath: IndexPath)
    
}

protocol CourseListDataManagerOutputProtocol: AnyObject {
    func readAndAddCoursesToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func filteredCoursesResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func clearCourseFilterResult(_ result: MDOperationResultWithoutCompletion<Void>)
}

protocol CourseListDataManagerProtocol: CourseListDataManagerInputProtocol {
    var dataManagerOutput: CourseListDataManagerOutputProtocol? { get set }
}

final class CourseListDataManager: CourseListDataManagerProtocol {
    
    fileprivate let coreDataStorage: MDCourseCoreDataStorageProtocol
    fileprivate let filterSearchTextService: MDFilterSearchTextServiceProtocol
    fileprivate let languageMemoryStorage: MDLanguageMemoryStorageProtocol
    
    internal var dataProvider: CourseListDataProviderProtocol
    internal weak var dataManagerOutput: CourseListDataManagerOutputProtocol?
    
    init(coreDataStorage: MDCourseCoreDataStorageProtocol,
         dataProvider: CourseListDataProviderProtocol,
         filterSearchTextService: MDFilterSearchTextServiceProtocol,
         languageMemoryStorage: MDLanguageMemoryStorageProtocol) {
        
        self.coreDataStorage = coreDataStorage
        self.dataProvider = dataProvider
        self.filterSearchTextService = filterSearchTextService
        self.languageMemoryStorage = languageMemoryStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CourseListDataManagerInputProtocol
extension CourseListDataManager: CourseListDataManagerInputProtocol {
    
    func readAndAddCoursesToDataProvider() {
        
        coreDataStorage.readAllCourses(ascending: false) { [unowned self] readResult in
            
            switch readResult {
                
            case .success(let readCourses):
                
                DispatchQueue.main.async {
                    
                    // Set Read Courses
                    let configuredCourses = self.configuredCourses(readCourses)
                    self.dataProvider.availableCourses = configuredCourses
                    self.dataProvider.coursesForUse = configuredCourses
                    //
                    
                    // Pass Result
                    self.dataManagerOutput?.readAndAddCoursesToDataProviderResult(.success(()))
                    //
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    
                    // Pass Result
                    self.dataManagerOutput?.readAndAddCoursesToDataProviderResult(.failure(error))
                    //
                    
                }
                
                //
                break
                //
                
            }
            
        }
        
    }
    
    func filterCourses(_ searchText: String?) {
        
        //
        filterSearchTextService.filter(input: dataProvider.availableCourses,
                                       searchText: searchText) { [unowned self] (filteredResult) in
            
            DispatchQueue.main.async {
                
                // Set Filtered Result
                self.dataProvider.coursesForUse = filteredResult as! [MDCourseListModel]
                //
                
                // Pass Result
                self.dataManagerOutput?.filteredCoursesResult(.success(()))
                //
                
            }
            
        }
        
    }
    
    func clearCourseFilter() {
        
        //
        self.dataProvider.coursesForUse = self.dataProvider.availableCourses
        //
        
        // Pass Result
        self.dataManagerOutput?.clearCourseFilterResult(.success(()))
        //
        
    }
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        dataProvider.deleteCourse(atIndexPath: indexPath)
    }
    
    func addCourse(atNewCourse course: MDCourseListModel) -> IndexPath {
        //
        self.dataProvider.coursesForUse.insert(course, at: .zero)
        //
        return .init(row: .zero, section: .zero)
    }
    
}

// MARK: - Public Methods
extension CourseListDataManager {
        
    func configuredCourses(_ input: [CDCourseEntity]) -> [MDCourseListModel] {
    
        var result: [MDCourseListModel] = .init()
        
        input.forEach { cdCourseEntity in
            
            switch languageMemoryStorage.readLanguage(byLanguageId: cdCourseEntity.languageId) {
        
            case .success(let language):
                
                //
                result.append(.init(course: cdCourseEntity,
                                    language: language))
                //
                
                //
                break
                //
                
            case .failure:
                
                //
                break
                //
                
            }
            
        }
        
        return result
        
    }
    
}
