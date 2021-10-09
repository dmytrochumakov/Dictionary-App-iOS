//
//  MDLanguageStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import Foundation

protocol MDLanguageStorageProtocol: MDStorageProtocol {
    
    var memoryStorage: MDLanguageMemoryStorageProtocol { get }
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageResponse],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>))
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>))
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>))
    
}

final class MDLanguageStorage: MDStorage, MDLanguageStorageProtocol {
    
    let memoryStorage: MDLanguageMemoryStorageProtocol
    fileprivate let coreDataStorage: MDLanguageCoreDataStorageProtocol
    
    init(memoryStorage: MDLanguageMemoryStorageProtocol,
         coreDataStorage: MDLanguageCoreDataStorageProtocol) {
        
        self.memoryStorage = memoryStorage
        self.coreDataStorage = coreDataStorage
        
        super.init(memoryStorage: memoryStorage,
                   coreDataStorage: coreDataStorage)
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - CRUD
extension MDLanguageStorage {       
    
    func createLanguages(storageType: MDStorageType,
                         languageEntities: [LanguageResponse],
                         _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>)) {
        
        debugPrint(#function, Self.self, "Start")
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.createLanguages(languageEntities) { result in
                debugPrint(#function, Self.self, "memory -> with result:", result)
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.createLanguages(languageEntities) { result in
                debugPrint(#function, Self.self, "coredata -> with result:", result)
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
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>> = []
            
            // Create in Memory
            self.memoryStorage.createLanguages(languageEntities) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    debugPrint(#function, Self.self, "all -> memory -> with result:", result)
                    completionHandler(finalResult)
                }
                
            }
            
            // Create in Core Data
            self.coreDataStorage.createLanguages(languageEntities) { result in
                
                // Append Result
                finalResult.append(.init(storageType: .coreData, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    debugPrint(#function, Self.self, "all -> coredata -> with result:", result)
                    completionHandler(finalResult)
                }
                
            }
            
            //
            break
            //
            
        }
        
    }
    
    func readAllLanguages(storageType: MDStorageType,
                          _ completionHandler: @escaping(MDStorageResultsWithCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.readAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
            
        case .coreData:
            
            //
            self.coreDataStorage.readAllLanguages { result in
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
            var finalResult: MDStorageResultsWithoutCompletion<MDOperationsResultWithoutCompletion<LanguageResponse>> = []
            
            // Read From Memory
            self.memoryStorage.readAllLanguages { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Read From Core Data
            self.coreDataStorage.readAllLanguages { result in
                
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
    
    func deleteAllLanguages(storageType: MDStorageType,
                            _ completionHandler: @escaping (MDStorageResultsWithCompletion<MDOperationResultWithoutCompletion<Void>>)) {
        
        switch storageType {
            
        case .memory:
            
            //
            self.memoryStorage.deleteAllLanguages { result in
                completionHandler([.init(storageType: storageType, result: result)])
            }
            //
            
            //
            break
            //
            
        case .coreData:
            
            //
            self.coreDataStorage.deleteAllLanguages { result in
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
            
            // Delete From Memory
            self.memoryStorage.deleteAllLanguages { result in
                
                // Append Result
                finalResult.append(.init(storageType: .memory, result: result))
                
                // Pass Final Result If Needed
                if (finalResult.count == countNeeded) {
                    completionHandler(finalResult)
                }
                //
                
            }
            
            // Delete From Core Data
            self.coreDataStorage.deleteAllLanguages { result in
                
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
