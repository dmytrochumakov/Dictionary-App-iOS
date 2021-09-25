//
//  CourseListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import Foundation

protocol CourseListDataManagerInputProtocol {
    var dataProvider: CourseListDataProviderProtocol { get }
    func addCourse(atNewCourse course: CourseResponse) -> IndexPath
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
    
    func readAndAddCoursesToDataProvider() {
        
        memoryStorage.readAllCourses { [weak self] readResult in
            
            switch readResult {
            
            case .success(let readCourses):
                // Set Read Courses
                self?.dataProvider.filteredCourses = readCourses
                // Pass Result
                self?.dataManagerOutput?.readAndAddCoursesToDataProviderResult(.success(()))
                //
                break
            //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.readAndAddCoursesToDataProviderResult(.failure(error))
                //
                break
            //
            }
            
        }
        
    }
    
    func filterCourses(_ searchText: String?) {
        
        memoryStorage.readAllCourses { [weak self] readResult in
            
            switch readResult {
            
            case .success(let readCourses):
                // Set Filtered Result
                self?.dataProvider.filteredCourses = self?.filteredCourses(input: readCourses,
                                                                           searchText: searchText) ?? []
                // Pass Result
                self?.dataManagerOutput?.filteredCoursesResult(.success(()))
                //
                break
            //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.filteredCoursesResult(.failure(error))
                //
                break
            //
            }
            
        }
        
    }
    
    func clearCourseFilter() {
        
        memoryStorage.readAllCourses { [weak self] readResult in
            
            switch readResult {
            
            case .success(let readCourses):
                // Set Read Courses
                self?.dataProvider.filteredCourses = readCourses
                // Pass Result
                self?.dataManagerOutput?.clearCourseFilterResult(.success(()))
                //
                break
            //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.clearCourseFilterResult(.failure(error))
                //
                break
            //
            }
            
        }
        
    }
    
    func deleteCourse(atIndexPath indexPath: IndexPath) {
        dataProvider.deleteCourse(atIndexPath: indexPath)
    }
    
    func addCourse(atNewCourse course: CourseResponse) -> IndexPath {
        //
        self.dataProvider.filteredCourses.append(course)
        //
        let section = (dataProvider.numberOfSections - 1)
        let row = (dataProvider.numberOfRowsInSection(section) - 1)
        return .init(row: row, section: section)
    }
    
}

fileprivate extension CourseListDataManager {
    
    func filteredCourses(input courses: [CourseResponse],
                         searchText: String?) -> [CourseResponse] {
        if (MDConstants.Text.textIsEmpty(searchText)) {
            return courses
        } else {
            return courses.filter({ $0.languageName.lowercased().contains(searchText!.lowercased()) })
        }
    }
    
}
