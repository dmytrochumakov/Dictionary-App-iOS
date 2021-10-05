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
    fileprivate let operationQueue: OperationQueue
    
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
         bridge: MDBridgeProtocol,
         operationQueue: OperationQueue) {
        //
        self.isLoggedIn = isLoggedIn
        self.jwtStorage = jwtStorage
        self.userStorage = userStorage
        self.languageStorage = languageStorage
        self.courseStorage = courseStorage
        self.wordStorage = wordStorage
        self.bridge = bridge
        self.operationQueue = operationQueue
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
        
        let operation: BlockOperation = .init {
            
            if (self.isLoggedIn) {
                
                // Check If Service Not Running
                guard !self.isRunning else { completionHandler?(.failure(MDFillMemoryServiceError.serviceIsRunning)) ; return }
                
                // Set In Running
                self.setInternalIsRunningTrue()
                
                // Initialize Count Result
                var countResult: Int = .zero
                
                // Fill Memory
                let fillMemoryOperation = self.fillMemory() { [unowned self] results in
                    
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
                
                // Add Operation
                self.operationQueue.addOperation(fillMemoryOperation)
                //
                
            } else {
                return
            }
            
        }
        
        // Add Operation
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Fill
fileprivate extension MDFillMemoryService {
    
    func fillMemory(completionHandler: @escaping(([MDStorageServiceOperationResult]) -> Void)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            //
            let countNeeded: Int = MDStorageServiceType.allCases.count
            //
            
            var results: [MDStorageServiceOperationResult] = .init()
            
            let fillJWTMemoryFromCoreDataOperation = self.fillJWTMemoryFromCoreData() { result in
                
                // Append Result
                results.append(result)
                
                // Pass Final Result If Needed
                if (results.count == countNeeded) {
                    completionHandler(results)
                }
                //
                
            }
            
            let fillUserMemoryFromCoreDataOperation = self.fillUserMemoryFromCoreData() { result in
                
                // Append Result
                results.append(result)
                
                // Pass Final Result If Needed
                if (results.count == countNeeded) {
                    completionHandler(results)
                }
                //
                
            }
            
            let fillLanguageMemoryFromCoreDataOperation = self.fillLanguageMemoryFromCoreData() { result in
                
                // Append Result
                results.append(result)
                
                // Pass Final Result If Needed
                if (results.count == countNeeded) {
                    completionHandler(results)
                }
                //
                
            }
            
            let fillCourseMemoryFromCoreDataOperation = self.fillCourseMemoryFromCoreData() { result in
                
                // Append Result
                results.append(result)
                
                // Pass Final Result If Needed
                if (results.count == countNeeded) {
                    completionHandler(results)
                }
                //
                
            }
            
            let fillWordMemoryFromCoreDataOperation = self.fillWordMemoryFromCoreData() { result in
                
                // Append Result
                results.append(result)
                
                // Pass Final Result If Needed
                if (results.count == countNeeded) {
                    completionHandler(results)
                }
                //
                
            }
            
            // Add Operation
            self.operationQueue.addOperations([fillJWTMemoryFromCoreDataOperation,
                                               fillUserMemoryFromCoreDataOperation,
                                               fillLanguageMemoryFromCoreDataOperation,
                                               fillCourseMemoryFromCoreDataOperation,
                                               fillWordMemoryFromCoreDataOperation],
                                              waitUntilFinished: true)
            //
            
        }
        
        return operation
        
    }
    
    func fillJWTMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .jwt
            
            self.jwtStorage.readFirstJWT(storageType: self.fromCoreData) { [unowned self] readResults in
                
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
        
        return operation
        
    }
    
    func fillUserMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .user
            
            self.userStorage.readFirstUser(storageType: self.fromCoreData) { [unowned self] readResults in
                
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
        
        return operation
        
    }
    
    func fillLanguageMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .language
            
            self.languageStorage.readAllLanguages(storageType: self.fromCoreData) { [unowned self] readResults in
                
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
        
        return operation
        
    }
    
    func fillCourseMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .course
            
            self.courseStorage.readAllCourses(storageType: self.fromCoreData) { [unowned self] readResults in
                
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
        
        return operation
        
    }
    
    func fillWordMemoryFromCoreData(_ completionHandler: @escaping(MDStorageServiceOperationResultWithCompletion)) -> BlockOperation {
        
        let operation: BlockOperation = .init {
            
            let storageServiceType: MDStorageServiceType = .word
            
            self.wordStorage.readAllWords(storageType: self.fromCoreData) { [unowned self] readResults in
                
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
        
        return operation
        
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
