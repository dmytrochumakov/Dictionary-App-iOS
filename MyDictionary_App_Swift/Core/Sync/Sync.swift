//
//  Sync.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.08.2021.
//

import Foundation

protocol SyncProtocol {
    func start(withSyncItem item: Sync.SyncItem, completionHandler: @escaping(([SyncResult]) -> Void))
}

final class Sync: SyncProtocol {
    
    public struct SyncItem {
        let accessToken: String
        let password: String
        let userId: Int64
    }
    
    fileprivate let apiUser: MDAPIUserProtocol
    fileprivate let userStorage: MDUserStorageProtocol
    fileprivate let apiLanguage: MDAPILanguageProtocol
    fileprivate let languageStorage: MDLanguageStorageProtocol
    fileprivate let apiCourse: MDAPICourseProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let apiWord: MDAPIWordProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    init(apiUser: MDAPIUserProtocol,
         userStorage: MDUserStorageProtocol,
         apiLanguage: MDAPILanguageProtocol,
         languageStorage: MDLanguageStorageProtocol,
         apiCourse: MDAPICourseProtocol,
         courseStorage: MDCourseStorageProtocol,
         apiWord: MDAPIWordProtocol,
         wordStorage: MDWordStorageProtocol) {
        
        self.apiUser = apiUser
        self.userStorage = userStorage
        self.apiLanguage = apiLanguage
        self.languageStorage = languageStorage
        self.apiCourse = apiCourse
        self.courseStorage = courseStorage
        self.apiWord = apiWord
        self.wordStorage = wordStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension Sync {
    
    func start(withSyncItem item: SyncItem, completionHandler: @escaping(([SyncResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [SyncResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save User
        apiGetAndSaveUser(withSyncItem: item) { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Languages
        apiGetAndSaveLanguages(withSyncItem: item) { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Courses
        apiGetAndSaveCourses(withSyncItem: item) { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Words
        apiGetAndSaveWords(withSyncItem: item) { result in
            syncResults.append(result)
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
}

// MARK: - API
extension Sync {
    
    // User
    func apiGetAndSaveUser(withSyncItem item: SyncItem, completionHandler: @escaping(SyncResultWithCompletion)) {
     
        let syncStep: SyncStep = .user
        var countResult: Int = .zero
        
        apiUser.getUser(accessToken: item.accessToken,
                        byUserId: item.userId) { [weak self] userResult in
            
            switch userResult {
            
            case .success(let user):
                
                self?.userStorage.createUser(user,
                                             password: item.password,
                                             storageType: .all) { createUserResults in
                    
                    createUserResults.forEach { createUserResult in
                        
                        switch createUserResult.result {
                        
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createUserResults.count) {
                                completionHandler(.init(syncStep: syncStep, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                break
                
            }
            
        }
        
    }
    
    // Language
    func apiGetAndSaveLanguages(withSyncItem item: SyncItem, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .language
        var countResult: Int = .zero
        
        apiLanguage.getLanguages(accessToken: item.accessToken) { [weak self] languagesResult in
            
            switch languagesResult {
            
            case .success(let languages):
                
                self?.languageStorage.createLanguages(storageType: .all,
                                                      languageEntities: languages) { createLanguagesResults in
                    
                    createLanguagesResults.forEach { createLanguagesResult in
                        
                        switch createLanguagesResult.result {
                        
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createLanguagesResults.count) {
                                completionHandler(.init(syncStep: syncStep, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                break
            }
            
        }
        
    }
    
    // Course
    func apiGetAndSaveCourses(withSyncItem item: SyncItem, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .course
        var countResult: Int = .zero
        
        apiCourse.getCourses(accessToken: item.accessToken, byUserId: item.userId) { [weak self] coursesResult in
            
            switch coursesResult {
            
            case .success(let courses):
                
                self?.courseStorage.createCourses(storageType: .all, courseEntities: courses) { createCoursesResults in
                    
                    createCoursesResults.forEach { createCoursesResult in
                        
                        switch createCoursesResult.result {
                        
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createCoursesResults.count) {
                                completionHandler(.init(syncStep: syncStep, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                break
            }
            
        }
        
    }
    
    // Word
    func apiGetAndSaveWords(withSyncItem item: SyncItem, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .word
        var countResult: Int = .zero
        
        apiWord.getWords(accessToken: item.accessToken, byUserId: item.userId) { [weak self] wordsResult in
            
            switch wordsResult {
            
            case .success(let words):
                
                self?.wordStorage.createWords(words, storageType: .all) { createWordsResults in
                    
                    createWordsResults.forEach { createWordsResult in
                        
                        switch createWordsResult.result {
                        
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createWordsResults.count) {
                                completionHandler(.init(syncStep: syncStep, result: .success(())))
                                break
                            }
                            
                        case .failure(let error):
                            completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                            break
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                break
            }
            
        }
        
    }
    
}

final class MemorySync {
    
}

enum SyncStep {
    case user
    case language
    case course
    case word
}

struct SyncResult {
    let syncStep: SyncStep
    let result: SyncResultWithoutCompletion
}

typealias SyncResultWithoutCompletion = (Result<Void, Error>)
typealias SyncResultWithCompletion = ((SyncResult) -> Void)
