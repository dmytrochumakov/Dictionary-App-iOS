//
//  MDCreateLanguagesCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.08.2021.
//

import CoreData

final class MDCreateLanguagesCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStorage: MDLanguageCoreDataStorage
    fileprivate let languageEntities: [LanguageResponse]
    fileprivate let result: MDOperationsResultWithCompletion<LanguageResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDLanguageCoreDataStorage,
         languageEntities: [LanguageResponse],
         result: MDOperationsResultWithCompletion<LanguageResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.languageEntities = languageEntities
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        var result: [LanguageResponse] = []
        
        languageEntities.forEach { languageEntity in
            
            let newLanguage = CDLanguageResponseEntity.init(languageResponse: languageEntity,
                                                            insertIntoManagedObjectContext: self.managedObjectContext)
            
            self.coreDataStorage.save(languageID: newLanguage.languageId) { [weak self] saveResult in
                DispatchQueue.main.async {
                    switch saveResult {
                    case .success(let createdLanguage):
                        
                        result.append(createdLanguage)
                        
                        if (result.count == self?.languageEntities.count) {
                            self?.result?(.success(result))
                            self?.finish()
                        }
                        
                    case .failure(let error):
                        self?.result?(.failure(error))
                        self?.finish()
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
