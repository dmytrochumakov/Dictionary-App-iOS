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
    fileprivate let languageEntities: [LanguageEntity]
    fileprivate let result: MDEntityResult<[LanguageEntity]>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDLanguageCoreDataStorage,
         languageEntities: [LanguageEntity],
         result: MDEntityResult<[LanguageEntity]>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.languageEntities = languageEntities
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        var result: [LanguageEntity] = []
        
        languageEntities.forEach { languageEntity in
        
            let newLanguage = CDLanguageEntity.init(languageEntity: languageEntity,
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

