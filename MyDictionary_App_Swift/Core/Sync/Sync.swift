//
//  Sync.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.08.2021.
//

import Foundation

protocol SyncManagerProtocol {
    var isRunning: Bool { get }
    func start(withSyncItem item: Sync.Item)
    func retry(withSyncItem item: Sync.Item)
}

final class SyncManager: SyncManagerProtocol {
    
    fileprivate let sync: SyncProtocol
    
    // Default is false
    fileprivate var internalIsRunning: Bool
    
    public var isRunning: Bool {
        return self.internalIsRunning
    }
    
    init(sync: SyncProtocol) {
        self.internalIsRunning = false
        self.sync = sync
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    func start(withSyncItem item: Sync.Item) {
        
        // Check Is Sync Not Running
        guard !isRunning else { return }
        
        // Set In Running
        setInternalIsRunningTrue()
        
        // Start Sync
        sync.start(withSyncItem: item) { results in
            
            results.forEach { result in
                
                debugPrint(#function, Self.self, "step: ", result.syncStep)
                
                switch result.result {
                
                case .success:
                    
                    debugPrint(#function, Self.self, "step: ", result.syncStep, "Success")
                    
                case .failure(let error):
                    debugPrint(#function, Self.self, "step: ", result.syncStep, "Failure: ", error)
                }
            }
            
        }
        
    }
    
    func retry(withSyncItem item: Sync.Item) {
        
        // Check Is Sync Not Running
        guard !isRunning else { return }
        
        // Set In Running
        setInternalIsRunningTrue()
        
        // Retry
        sync.retry(withSyncItem: item) { results in
            
            results.forEach { result in
                
                debugPrint(#function, Self.self, "step: ", result.syncStep)
                
                switch result.result {
                
                case .success:
                    
                    debugPrint(#function, Self.self, "step: ", result.syncStep, "Success")
                    
                case .failure(let error):
                    debugPrint(#function, Self.self, "step: ", result.syncStep, "Failure: ", error)
                }
            }
            
        }
        
    }
    
    func setInternalIsRunning(_ newValue: Bool) {
        self.internalIsRunning = newValue
    }
    
    func setInternalIsRunningTrue() {
        self.setInternalIsRunning(true)
    }
    
    func setInternalIsRunningFalse() {
        self.setInternalIsRunning(false)
    }
    
}

protocol SyncProtocol {
    func start(withSyncItem item: Sync.Item, completionHandler: @escaping(([SyncResult]) -> Void))
    func retry(withSyncItem item: Sync.Item, completionHandler: @escaping(([SyncResult]) -> Void))
}

final class Sync: SyncProtocol {
    
    public struct Item {
        let accessToken: String
        let password: String
        let userId: Int64
        let nickname: String
    }
    
    fileprivate let apiJWT: MDAPIJWTProtocol
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let apiUser: MDAPIUserProtocol
    fileprivate let userStorage: MDUserStorageProtocol
    fileprivate let apiLanguage: MDAPILanguageProtocol
    fileprivate let languageStorage: MDLanguageStorageProtocol
    fileprivate let apiCourse: MDAPICourseProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let apiWord: MDAPIWordProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    init(apiJWT: MDAPIJWTProtocol,
         jwtStorage: MDJWTStorageProtocol,
         apiUser: MDAPIUserProtocol,
         userStorage: MDUserStorageProtocol,
         apiLanguage: MDAPILanguageProtocol,
         languageStorage: MDLanguageStorageProtocol,
         apiCourse: MDAPICourseProtocol,
         courseStorage: MDCourseStorageProtocol,
         apiWord: MDAPIWordProtocol,
         wordStorage: MDWordStorageProtocol) {
        
        self.apiJWT = apiJWT
        self.jwtStorage = jwtStorage
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
    
    func start(withSyncItem item: Sync.Item, completionHandler: @escaping(([SyncResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [SyncResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save JWT
        apiGetAndSaveJWT(withSyncItem: item) { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
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
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
    func retry(withSyncItem item: Sync.Item, completionHandler: @escaping(([SyncResult]) -> Void)) {
        
        deleteAllData { [unowned self] deleteAllDataResults in
            
            start(withSyncItem: item) { syncResults in
                completionHandler(deleteAllDataResults + syncResults)
            }
            
        }
        
    }
    
    func deleteAllData(completionHandler: @escaping(([SyncResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [SyncResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All JWT
        deleteAllJWT { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Users
        deleteAllUsers { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Languages
        deleteAllLanguages { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Courses
        deleteAllCourses { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Delete All Words
        deleteAllWords { result in
            // Append Sync Result
            syncResults.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
}

// MARK: - Delete Data
extension Sync {
    
    func deleteAllJWT(completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .jwt
        var countResult: Int = .zero
        
        jwtStorage.deleteAllJWT(storageType: .all) { deleteJWTsResults in
            
            deleteJWTsResults.forEach { deleteJWTsResult in
                
                switch deleteJWTsResult.result {
                
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteJWTsResults.count) {
                        completionHandler(.init(syncStep: syncStep, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllUsers(completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .user
        var countResult: Int = .zero
        
        userStorage.deleteAllUsers(storageType: .all) { deleteUsersResults in
            
            deleteUsersResults.forEach { deleteUsersResult in
                
                switch deleteUsersResult.result {
                
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteUsersResults.count) {
                        completionHandler(.init(syncStep: syncStep, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllLanguages(completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .language
        var countResult: Int = .zero
        
        languageStorage.deleteAllLanguages(storageType: .all) { deleteLanguagesResults in
            
            deleteLanguagesResults.forEach { deleteLanguagesResult in
                
                switch deleteLanguagesResult.result {
                
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteLanguagesResults.count) {
                        completionHandler(.init(syncStep: syncStep, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllCourses(completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .course
        var countResult: Int = .zero
        
        courseStorage.deleteAllCourses(storageType: .all) { deleteCoursesResults in
            
            deleteCoursesResults.forEach { deleteCoursesResult in
                
                switch deleteCoursesResult.result {
                
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteCoursesResults.count) {
                        completionHandler(.init(syncStep: syncStep, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
    func deleteAllWords(completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .word
        var countResult: Int = .zero
        
        wordStorage.deleteAllWords(storageType: .all) { deleteWordsResults in
            
            deleteWordsResults.forEach { deleteWordsResult in
                
                switch deleteWordsResult.result {
                
                case .success:
                    
                    countResult += 1
                    
                    if (countResult == deleteWordsResults.count) {
                        completionHandler(.init(syncStep: syncStep, result: .success(())))
                    }
                    
                case .failure(let error):
                    completionHandler(.init(syncStep: syncStep, result: .failure(error)))
                }
                
            }
            
        }
        
    }
    
}

// MARK: - API
extension Sync {
    
    // JWT
    func apiGetAndSaveJWT(withSyncItem item: Sync.Item, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .jwt
        var countResult: Int = .zero
        
        apiJWT.accessToken(jwtApiRequest: .init(nickname: item.nickname,
                                                password: item.password,
                                                userId: item.userId,
                                                oldJWT: item.accessToken)) { [unowned self] jwtResult in
            
            switch jwtResult {
            
            case .success(let jwt):
                
                jwtStorage.createJWT(storageType: .all,
                                     jwtResponse: jwt) { createJWTResults in
                    
                    createJWTResults.forEach { createJWTResult in
                        
                        switch createJWTResult.result {
                        
                        case .success:
                            
                            countResult += 1
                            
                            if (countResult == createJWTResults.count) {
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
    
    // User
    func apiGetAndSaveUser(withSyncItem item: Sync.Item, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .user
        var countResult: Int = .zero
        
        apiUser.getUser(accessToken: item.accessToken,
                        byUserId: item.userId) { [unowned self] userResult in
            
            switch userResult {
            
            case .success(let user):
                
                userStorage.createUser(user,
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
    func apiGetAndSaveLanguages(withSyncItem item: Sync.Item, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .language
        var countResult: Int = .zero
        
        apiLanguage.getLanguages(accessToken: item.accessToken) { [unowned self] languagesResult in
            
            switch languagesResult {
            
            case .success(let languages):
                
                languageStorage.createLanguages(storageType: .all,
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
    func apiGetAndSaveCourses(withSyncItem item: Sync.Item, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .course
        var countResult: Int = .zero
        
        apiCourse.getCourses(accessToken: item.accessToken, byUserId: item.userId) { [unowned self] coursesResult in
            
            switch coursesResult {
            
            case .success(let courses):
                
                courseStorage.createCourses(storageType: .all, courseEntities: courses) { createCoursesResults in
                    
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
    func apiGetAndSaveWords(withSyncItem item: Sync.Item, completionHandler: @escaping(SyncResultWithCompletion)) {
        
        let syncStep: SyncStep = .word
        var countResult: Int = .zero
        
        apiWord.getWords(accessToken: item.accessToken, byUserId: item.userId) { [unowned self] wordsResult in
            
            switch wordsResult {
            
            case .success(let words):
                
                wordStorage.createWords(words, storageType: .all) { createWordsResults in
                    
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
    case jwt
    case user
    case language
    case course
    case word
}

struct SyncResult {
    let syncStep: SyncStep
    let result: MDOperationResultWithoutCompletion<Void>
}

typealias SyncResultWithCompletion = ((SyncResult) -> Void)
