//
//  MDFillMemoryService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 02.09.2021.
//

import Foundation

protocol MDFillMemoryServiceProtocol {
    var isRunning: Bool { get }
    var isFilled: Bool { get }
    func fillMemoryFromCoreDataIfNeeded(completionHandler: (MDOperationResultWithCompletion<Void>)?)
}

final class MDFillMemoryService: MDFillMemoryServiceProtocol {
    
    fileprivate let isLoggedIn: Bool
    fileprivate let jwtStorage: MDJWTStorageProtocol
    fileprivate let userStorage: MDUserStorageProtocol
    fileprivate let languageStorage: MDLanguageStorageProtocol
    fileprivate let courseStorage: MDCourseStorageProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    fileprivate var bridge: MDBridgeProtocol
    
    // Default is .coreData
    fileprivate let fromCoreData: MDStorageType = .coreData
    // Default is .memory
    fileprivate let toMemory: MDStorageType = .memory
    
    // Default is false
    fileprivate var internalIsRunning: Bool
    
    // Default is false
    fileprivate var internalIsFilled: Bool
    
    public var isRunning: Bool {
        return internalIsRunning
    }
    
    public var isFilled: Bool {
        return internalIsFilled
    }
    
    init(isLoggedIn: Bool,
         jwtStorage: MDJWTStorageProtocol,
         userStorage: MDUserStorageProtocol,
         languageStorage: MDLanguageStorageProtocol,
         courseStorage: MDCourseStorageProtocol,
         wordStorage: MDWordStorageProtocol,
         bridge: MDBridgeProtocol) {
        //
        self.isLoggedIn = isLoggedIn
        self.jwtStorage = jwtStorage
        self.userStorage = userStorage
        self.languageStorage = languageStorage
        self.courseStorage = courseStorage
        self.wordStorage = wordStorage
        self.bridge = bridge
        //
        self.internalIsRunning = false
        self.internalIsFilled = false
        //
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDFillMemoryService {
    
    func fillMemoryFromCoreDataIfNeeded(completionHandler: (MDOperationResultWithCompletion<Void>)? = nil) {
        
        if (isLoggedIn) {
            
            // Check If Service Not Running
            guard !isRunning else { completionHandler?(.failure(MDFillMemoryServiceError.serviceIsRunning)) ; return }
            
            // Set In Running
            setInternalIsRunningTrue()
            
            // Initialize Count Result
            var countResult: Int = .zero
            
            // Fill Memory
            fillMemory() { [unowned self] results in
                
                results.forEach { result in
                    
                    debugPrint(#function, Self.self, "step: ", result.storageServiceType)
                    
                    switch result.result {
                        
                    case .success:
                        //
                        debugPrint(#function, Self.self, "step: ", result.storageServiceType, "Success")
                        //
                        countResult += 1
                        //
                        if (countResult == results.count) {
                            //
                            setInternalIsRunningFalse()
                            //
                            setInternalIsFilledTrue()
                            //
                            setDidChangeMemoryIsFilledResult(.success(()))
                            //
                            completionHandler?(.success(()))
                            //
                            break
                            //
                        }
                        //
                    case .failure(let error):
                        //
                        debugPrint(#function, Self.self, "step: ", result.storageServiceType, "Failure: ", error)
                        //
                        setInternalIsRunningFalse()
                        //
                        setInternalIsFilledFalse()
                        //
                        setDidChangeMemoryIsFilledResult(.failure(error))
                        //
                        completionHandler?(.failure(error))
                        //
                        return
                    }
                }
                
            }
            
        } else {
            return
        }
        
    }
    
}

// MARK: - Fill
fileprivate extension MDFillMemoryService {
    
    func fillMemory(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) {
        
        var results: [MDStorageServiceOperationResult] = .init()
        
        // Initialize Dispatch Group
        let dispatchGroup: DispatchGroup = .init()
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        fillJWTMemoryFromCoreData() { result in
            // Append Result
            results.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        fillUserMemoryFromCoreData() { result in
            // Append Result
            results.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        fillLanguageMemoryFromCoreData() { result in
            // Append Result
            results.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        fillCourseMemoryFromCoreData() { result in
            // Append Result
            results.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Dispatch Group Enter
        dispatchGroup.enter()
        fillWordMemoryFromCoreData() { result in
            // Append Result
            results.append(result)
            // Dispatch Group Leave
            dispatchGroup.leave()
        }
        
        // Notify And Pass Final Result
        dispatchGroup.notify(queue: .main) {
            completionHandler(results)
        }
        
    }
    
    func fillJWTMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .jwt
        
        jwtStorage.readFirstJWT(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
                
            case .success(let jwt):
                
                jwtStorage.createJWT(storageType: toMemory,
                                     jwtResponse: jwt) { createResults in
                    
                    switch createResults.first!.result {
                        
                    case .success:
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                        break
                    case .failure(let error):
                        completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                return
            }
            
        }
        
    }
    
    func fillUserMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .user
        
        userStorage.readFirstUser(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
                
            case .success(let user):
                
                userStorage.createUser(user,
                                       password: user.password!,
                                       storageType: toMemory) { createResults in
                    
                    switch createResults.first!.result {
                        
                    case .success:
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                        break
                    case .failure(let error):
                        completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                return
            }
            
        }
        
    }
    
    func fillLanguageMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .language
        
        languageStorage.readAllLanguages(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
                
            case .success(let languages):
                
                languageStorage.createLanguages(storageType: toMemory,
                                                languageEntities: languages) { createResults in
                    
                    switch createResults.first!.result {
                        
                    case .success:
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                        break
                    case .failure(let error):
                        completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                return
            }
            
        }
        
    }
    
    func fillCourseMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .course
        
        courseStorage.readAllCourses(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
                
            case .success(let courses):
                
                courseStorage.createCourses(storageType: toMemory,
                                            courseEntities: courses) { createResults in
                    
                    switch createResults.first!.result {
                        
                    case .success:
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                        break
                    case .failure(let error):
                        completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                return
            }
            
        }
        
    }
    
    func fillWordMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) {
        
        let storageServiceType: MDStorageServiceType = .word
        
        wordStorage.readAllWords(storageType: fromCoreData) { [unowned self] readResults in
            
            switch readResults.first!.result {
                
            case .success(let words):
                
                wordStorage.createWords(words, storageType: toMemory) { createResults in
                    
                    switch createResults.first!.result {
                        
                    case .success:
                        completionHandler(.init(storageServiceType: storageServiceType, result: .success(())))
                        break
                    case .failure(let error):
                        completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                        return
                    }
                    
                }
                
                break
            case .failure(let error):
                completionHandler(.init(storageServiceType: storageServiceType, result: .failure(error)))
                return
            }
            
        }
        
    }
    
}

// MARK: - Set Internal Properties
fileprivate extension MDFillMemoryService {
    
    // Is Running
    func setInternalIsRunning(_ newValue: Bool) {
        self.internalIsRunning = newValue
    }
    
    func setInternalIsRunningTrue() {
        self.setInternalIsRunning(true)
    }
    
    func setInternalIsRunningFalse() {
        self.setInternalIsRunning(false)
    }
    
    // Is Filled
    func setInternalIsFilled(_ newValue: Bool) {
        self.internalIsFilled = newValue
    }
    
    func setInternalIsFilledTrue() {
        self.setInternalIsFilled(true)
    }
    
    func setInternalIsFilledFalse() {
        self.setInternalIsFilled(false)
    }
    
    // didChangeMemoryIsFilledResult
    func setDidChangeMemoryIsFilledResult(_ newValue: MDOperationResultWithoutCompletion<Void>) {
        bridge.didChangeMemoryIsFilledResult?(newValue)        
    }
    
}
