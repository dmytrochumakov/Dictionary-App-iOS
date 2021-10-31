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
    
    fileprivate let coreDataStorage: MDCourseCoreDataStorageProtocol
    fileprivate let filterSearchTextService: MDFilterSearchTextService<CourseResponse>
    
    internal var dataProvider: CourseListDataProviderProtocol
    internal weak var dataManagerOutput: CourseListDataManagerOutputProtocol?
    
    init(coreDataStorage: MDCourseCoreDataStorageProtocol,
         dataProvider: CourseListDataProviderProtocol,
         filterSearchTextService: MDFilterSearchTextService<CourseResponse>) {
        
        self.coreDataStorage = coreDataStorage
        self.dataProvider = dataProvider
        self.filterSearchTextService = filterSearchTextService
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CourseListDataManagerInputProtocol
extension CourseListDataManager {
    
    func readAndAddCoursesToDataProvider() {
        
        coreDataStorage.readAllCourses { [unowned self] readResult in
            
            switch readResult {
                
            case .success(let readCourses):
                
                // Sort
                let sordedCourses = sortCourses(readCourses)
                //
                
                DispatchQueue.main.async {
                    
                    // Set Read Courses
                    self.dataProvider.filteredCourses = sordedCourses
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
        
        coreDataStorage.readAllCourses { [unowned self] readResult in
            
            switch readResult {
                
            case .success(let readCourses):
                
                // Sort
                let sordedCourses = sortCourses(readCourses)
                //
                
                //
                filterSearchTextService.filter(input: sordedCourses,
                                               searchText: searchText) { [unowned self] (filteredResult) in
                    
                    DispatchQueue.main.async {
                        
                        // Set Filtered Result
                        self.dataProvider.filteredCourses = filteredResult
                        
                        // Pass Result
                        self.dataManagerOutput?.filteredCoursesResult(.success(()))
                        //
                        
                    }
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    
                    // Pass Result
                    self.dataManagerOutput?.filteredCoursesResult(.failure(error))
                    //
                    
                }
                
                //
                break
                //
            }
            
        }
        
    }
    
    func clearCourseFilter() {
        
        coreDataStorage.readAllCourses { [unowned self] readResult in
            
            switch readResult {
                
            case .success(let readCourses):
                
                // Sort
                let sordedCourses = sortCourses(readCourses)
                //
                
                DispatchQueue.main.async {
                    
                    // Set Read Courses
                    self.dataProvider.filteredCourses = sordedCourses
                    //
                    
                    // Pass Result
                    self.dataManagerOutput?.clearCourseFilterResult(.success(()))
                    //
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    
                    // Pass Result
                    self.dataManagerOutput?.clearCourseFilterResult(.failure(error))
                    //
                    
                }
                
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
        self.dataProvider.filteredCourses.insert(course, at: .zero)
        //
        return .init(row: .zero, section: .zero)
    }
    
}

// MARK: - Private Methods
fileprivate extension CourseListDataManager {
    
    func sortCourses(_ input: [CourseResponse]) -> [CourseResponse] {
        return input.sorted(by: { $0.createdAtDate > $1.createdAtDate })
    }
    
}
