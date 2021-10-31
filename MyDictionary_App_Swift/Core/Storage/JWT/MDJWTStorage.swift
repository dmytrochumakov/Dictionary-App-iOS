//
//  MDJWTStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 15.08.2021.
//

import Foundation

protocol MDJWTStorageProtocol: MDStorageProtocol {
    
    func createJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>))
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>))
    
    func readFirstJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>))
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteJWT(storageType: MDStorageType,
                   accessToken: String,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
    func deleteAllJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
}

final class MDJWTStorage: MDStorage, MDJWTStorageProtocol {
    
    fileprivate let coreDataStorage: MDJWTCoreDataStorageProtocol
    
    init(coreDataStorage: MDJWTCoreDataStorageProtocol) {
        
        self.coreDataStorage = coreDataStorage
        
        super.init(coreDataStorage: coreDataStorage)
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CRUD
extension MDJWTStorage {
    
    func createJWT(storageType: MDStorageType,
                   jwtResponse: JWTResponse,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
        debugPrint(#function, Self.self, "Start")
        
        switch storageType {
            
        case .coreData:
            
            
            //
            self.coreDataStorage.createJWT(jwtResponse) { (result) in
                debugPrint(#function, Self.self, "coredata -> finish -> with result:", result)
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
            
            // Create in Core Data
            self.coreDataStorage.createJWT(jwtResponse) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    debugPrint(#function, Self.self, "all -> coredata -> with result:", result)
                    completionHandler(finalResult)
                }
                //
                
            }
            
            
            //
            break
            //
            
        }
        
    }
    
    func readFirstJWT(storageType: MDStorageType,
                      _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
        switch storageType {
            
        case .coreData:
            
            //
            self.coreDataStorage.readFirstJWT() { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<JWTResponse>> = []
                       
            // Read From Core Data
            self.coreDataStorage.readFirstJWT() { (result) in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func readJWT(storageType: MDStorageType,
                 fromAccessToken accessToken: String,
                 _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<JWTResponse>>)) {
        
        switch storageType {
            
        case .coreData:
            
            //
            self.coreDataStorage.readJWT(fromAccessToken: accessToken) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            // Read From Core Data
            self.coreDataStorage.readJWT(fromAccessToken: accessToken) { (result) in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func updateJWT(storageType: MDStorageType,
                   oldAccessToken accessToken: String,
                   newJWTResponse jwtResponse: JWTResponse,
                   _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .coreData:
            
            //
            self.coreDataStorage.updateJWT(oldAccessToken: accessToken, newJWTResponse: jwtResponse) { (result) in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Update In Core Data
            self.coreDataStorage.updateJWT(oldAccessToken: accessToken,
                                           newJWTResponse: jwtResponse) { (result) in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func deleteJWT(storageType: MDStorageType,
                   accessToken: String,
                   _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .coreData:
            
            //
            self.coreDataStorage.deleteJWT(accessToken) { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Core Data
            self.coreDataStorage.deleteJWT(accessToken) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            
            //
            break
            //
            
        }
        
    }
    
    func deleteAllJWT(storageType: MDStorageType, _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .coreData:
            
            //
            self.coreDataStorage.deleteAllJWT { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .all:
            
            //
            let countNeeded: Int = 2
            //
            
            // Initialize final result
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationResultWithoutCompletion<Void>> = []
            
            // Delete From Core Data
            self.coreDataStorage.deleteAllJWT { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            
            //
            break
            //
            
        }
        
    }
    
}
