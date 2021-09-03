//
//  MDFillMemoryService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 02.09.2021.
//

import Foundation

protocol MDFillMemoryServiceProtocol {
    func fillMemoryFromCoreDataIfNeeded()
}

final class MDFillMemoryService: MDFillMemoryServiceProtocol {
    
    fileprivate let isLoggedIn: Bool
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let userStorage: MDUserStorageProtocol
    fileprivate let languageStorage: MDLanguageStorageProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    // Default is .coreData
    fileprivate let fromCoreData: MDStorageType = .coreData
    // Default is .memory
    fileprivate let toMemory: MDStorageType = .memory
    
    init(isLoggedIn: Bool,
         jwtStorage: MDJWTStorageProtocol,
         userStorage: MDUserStorageProtocol,
         languageStorage: MDLanguageStorageProtocol,
         courseStorage: MDCourseStorageProtocol,
         wordStorage: MDWordStorageProtocol) {
        
        self.isLoggedIn = isLoggedIn
        self.jwtStorage = jwtStorage
        self.userStorage = userStorage
        self.languageStorage = languageStorage
        self.courseStorage = courseStorage
        self.wordStorage = wordStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDFillMemoryService {
    
    func fillMemoryFromCoreDataIfNeeded() {
        
        if (isLoggedIn) {
            fillJWTMemoryFromCoreData()
            fillUserMemoryFromCoreData()
            fillLanguageMemoryFromCoreData()
            fillCourseMemoryFromCoreData()
            fillWordMemoryFromCoreData()
        } else {
            return
        }
        
    }
    
}

// MARK: - Fill
fileprivate extension MDFillMemoryService {
    
    func fillJWTMemoryFromCoreData() {
        
        jwtStorage.readFirstJWT(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
            
            case .success(let jwt):
                
                jwtStorage.createJWT(storageType: toMemory,
                                     jwtResponse: jwt) { createResults in
                    
                    switch createResults.first!.result {
                    
                    case .success:
                        debugPrint(#function, Self.self, "Success")
                        break
                    case .failure(let error):
                        debugPrint(#function, Self.self, "Failure: ", error)
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", error)
                return
            }
            
        }
        
    }
    
    func fillUserMemoryFromCoreData() {
        
        userStorage.readFirstUser(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
            
            case .success(let user):
                
                userStorage.createUser(user,
                                       password: user.password!,
                                       storageType: toMemory) { createResults in
                    
                    switch createResults.first!.result {
                    
                    case .success:
                        debugPrint(#function, Self.self, "Success")
                        break
                    case .failure(let error):
                        debugPrint(#function, Self.self, "Failure: ", error)
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", error)
                return
            }
            
        }
        
    }
    
    func fillLanguageMemoryFromCoreData() {
        
        languageStorage.readAllLanguages(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
            
            case .success(let languages):
                
                languageStorage.createLanguages(storageType: toMemory,
                                                languageEntities: languages) { createResults in
                    
                    switch createResults.first!.result {
                    
                    case .success:
                        debugPrint(#function, Self.self, "Success")
                        break
                    case .failure(let error):
                        debugPrint(#function, Self.self, "Failure: ", error)
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", error)
                return
            }
            
        }
        
    }
    
    func fillCourseMemoryFromCoreData() {
        
        courseStorage.readAllCourses(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
            
            case .success(let courses):
                
                courseStorage.createCourses(storageType: toMemory,
                                            courseEntities: courses) { createResults in
                    
                    switch createResults.first!.result {
                    
                    case .success:
                        debugPrint(#function, Self.self, "Success")
                        break
                    case .failure(let error):
                        debugPrint(#function, Self.self, "Failure: ", error)
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", error)
                return
            }
            
        }
        
    }
    
    func fillWordMemoryFromCoreData() {
        
        wordStorage.readAllWords(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
            
            case .success(let words):
                
                wordStorage.createWords(words, storageType: toMemory) { createResults in
                    
                    switch createResults.first!.result {
                    
                    case .success:
                        debugPrint(#function, Self.self, "Success")
                        break
                    case .failure(let error):
                        debugPrint(#function, Self.self, "Failure: ", error)
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                debugPrint(#function, Self.self, "Failure: ", error)
                return
            }
            
        }
        
    }
    
}
