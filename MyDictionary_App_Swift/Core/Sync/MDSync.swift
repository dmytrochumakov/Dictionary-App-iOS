//
//  MDSync.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.08.2021.
//

import Foundation

protocol MDSyncProtocol {
    
    func startFullSyncWithDeleteAllData(withSyncItem item: MDSync.Item,
                                        progressCompletionHandler: @escaping((Float) -> Void),
                                        completionHandler: @escaping(([MDSyncResult]) -> Void))
    
    func startWithJWTAndUserAndLanguageSync(withSyncItem item: MDSync.Item,
                                            progressCompletionHandler: @escaping((Float) -> Void),
                                            completionHandler: @escaping(([MDSyncResult]) -> Void))
    
}

final class MDSync: MDSyncProtocol {
    
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

extension MDSync {
    
    func startFullSyncWithDeleteAllData(withSyncItem item: MDSync.Item,
                                        progressCompletionHandler: @escaping((Float) -> Void),
                                        completionHandler: @escaping(([MDSyncResult]) -> Void)) {
        
        deleteAllData { [unowned self] deleteAllDataResults in
            
            startFullSync(withSyncItem: item) { progress in
                progressCompletionHandler(progress)
            } completionHandler: { syncResults in
                completionHandler(deleteAllDataResults + syncResults)
            }
            
        }
        
    }
    
    func startWithJWTAndUserAndLanguageSync(withSyncItem item: Item,
                                            progressCompletionHandler: @escaping((Float) -> Void),
                                            completionHandler: @escaping (([MDSyncResult]) -> Void)) {
        
        jwtAndUserAndLanguageSync(withSyncItem: item,
                                  progressCompletionHandler: progressCompletionHandler,
                                  completionHandler: completionHandler)
        
    }
    
}

fileprivate extension MDSync {
    
    func startFullSync(withSyncItem item: MDSync.Item,
                       progressCompletionHandler: @escaping((Float) -> Void),
                       completionHandler: @escaping(([MDSyncResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDSyncResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save JWT
        apiGetAndSaveJWT(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save User
        apiGetAndSaveUser(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Languages
        apiGetAndSaveLanguages(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Courses
        apiGetAndSaveCourses(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Words
        apiGetAndSaveWords(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
    func jwtAndUserAndLanguageSync(withSyncItem item: Item,
                                   progressCompletionHandler: @escaping((Float) -> Void),
                                   completionHandler: @escaping (([MDSyncResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDSyncResult] = []
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save JWT
        apiGetAndSaveJWT(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save User
        apiGetAndSaveUser(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        // Get API And Save Languages
        apiGetAndSaveLanguages(withSyncItem: item) { [unowned self] result in
            // Append Sync Result
            syncResults.append(result)
            // Compute And Pass Progress
            progressCompletionHandler(computeProgress(finishedOperationsCount: syncResults.count))
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(syncResults)
        }
        
    }
    
    func computeProgress(finishedOperationsCount: Int) -> Float {
        return Float(finishedOperationsCount) / Float(MDSyncStep.allCases.count)
    }
    
}

// MARK: - Delete Data
fileprivate extension MDSync {
    
    func deleteAllData(completionHandler: @escaping(([MDSyncResult]) -> Void)) {
        
        // Initialize Sync Results
        var syncResults: [MDSyncResult] = []
        
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
    
    func deleteAllJWT(completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .jwt
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
    
    func deleteAllUsers(completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .user
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
    
    func deleteAllLanguages(completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .language
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
    
    func deleteAllCourses(completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .course
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
    
    func deleteAllWords(completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .word
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
fileprivate extension MDSync {
    
    // JWT
    func apiGetAndSaveJWT(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .jwt
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
    func apiGetAndSaveUser(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .user
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
    func apiGetAndSaveLanguages(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .language
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
    func apiGetAndSaveCourses(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .course
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
    func apiGetAndSaveWords(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDSyncResultWithCompletion)) {
        
        let syncStep: MDSyncStep = .word
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
