//
//  MDCreateLanguagesCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import CoreData

final class MDCreateLanguagesCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let coreDataStorage: MDLanguageCoreDataStorage
    fileprivate let languageEntities: [LanguageResponse]
    fileprivate let result: MDOperationsResultWithCompletion<LanguageResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         coreDataStorage: MDLanguageCoreDataStorage,
         languageEntities: [LanguageResponse],
         result: MDOperationsResultWithCompletion<LanguageResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.languageEntities = languageEntities
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        if (languageEntities.isEmpty) {
            
            self.result?(.success(self.languageEntities))
            self.finish()
            return
            
        } else {
            
            var resultCount: Int = .zero
            
            languageEntities.forEach { languageEntity in
                
                let _ = CDLanguageResponseEntity.init(languageResponse: languageEntity,
                                                      insertIntoManagedObjectContext: self.managedObjectContext)
                
                coreDataStack.save(managedObjectContext: managedObjectContext) { [weak self] result in
                    
                    switch result {
                        
                    case .success:
                        
                        resultCount += 1
                        
                        if (resultCount == self?.languageEntities.count) {
                            self?.result?(.success(self?.languageEntities ?? []))
                            self?.finish()
                            break
                        }
                        
                    case .failure(let error):
                        
                        self?.result?(.failure(error))
                        self?.finish()
                        break
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
