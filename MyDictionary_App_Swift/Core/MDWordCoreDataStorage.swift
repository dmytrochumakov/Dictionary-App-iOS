//
//  MDWordCoreDataStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

protocol MDWordCoreDataStorageProtocol: MDCRUDWordProtocol {
    
}

final class MDWordCoreDataStorage: NSObject,
                                   MDWordCoreDataStorageProtocol {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
}

// MARK: - Create
extension MDWordCoreDataStorage {
    
    func createWord(_ wordModel: WordModel, _ completionHandler: @escaping (MDCreateWordResult)) {
        let newWord = CDWordEntity.init(wordModel: wordModel,
                                        insertIntoManagedObjectContext: managedObjectContext)
        
        self.save(word: newWord, completionHandler: completionHandler)
    }
    
}

// MARK: - Read
extension MDWordCoreDataStorage {
    
    func readWord(fromUUID uuid: UUID, _ completionHandler: @escaping (MDReadWordResult)) {
        let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: CoreDataEntityName.CDWordEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %@", uuid.uuidString)
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                if let word = result.map({ $0.wordModel }).first {
                    DispatchQueue.main.async {
                        completionHandler(.success(word))
                    }
                }
            }
            
        }
        
        do {
            try managedObjectContext.execute(asynchronousFetchRequest)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func readWords(fetchLimit: Int, fetchOffset: Int, _ completionHandler: @escaping (MDReadWordsResult)) {
        let fetchRequest = NSFetchRequest<CDWordEntity>(entityName: CoreDataEntityName.CDWordEntity)
        fetchRequest.fetchLimit = fetchLimit
        fetchRequest.fetchOffset = fetchOffset
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                DispatchQueue.main.async {
                    completionHandler(.success(result.map({ $0.wordModel })))
                }
            }
            
        }
        
        do {
            try managedObjectContext.execute(asynchronousFetchRequest)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
}

// MARK: - Update
extension MDWordCoreDataStorage {
    
    func updateWord(byUUID uuid: UUID, word: WordModel, _ completionHandler: @escaping (MDUpdateWordResult)) {
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.CDWordEntity)
        batchUpdateRequest.propertiesToUpdate = [CDWordEntityAttributeName.word : word.word,
                                                 CDWordEntityAttributeName.wordDescription : word.wordDescription,
                                                 CDWordEntityAttributeName.wordLanguage : word.wordLanguage
        ]
        batchUpdateRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %@", word.uuid.uuidString)
        
        do {
            try managedObjectContext.execute(batchUpdateRequest)
            savePerform(word: word.cdWordEntity(insertIntoManagedObjectContext: managedObjectContext)) { [unowned self] (result) in
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Delete
extension MDWordCoreDataStorage {
    
    func deleteWord(_ word: WordModel, _ completionHandler: @escaping (MDDeleteWordResult)) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.CDWordEntity)
        fetchRequest.predicate = NSPredicate(format: "\(CDWordEntityAttributeName.uuid) == %@", word.uuid.uuidString)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            self.savePerform { [unowned self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        completionHandler(.success(word))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            }
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
}

// MARK: - Save
fileprivate extension MDWordCoreDataStorage {
    
    func savePerform(completionHandler: @escaping CDResultSaved) {
        coreDataStack.savePerform(completionHandler: completionHandler)
    }
    
    func savePerform(word: CDWordEntity, completionHandler: @escaping MDCDResultSavedWord) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromUUID: word.uuid!) { [unowned self] (result) in
                    switch result {
                    case .success(let wordModel):
                        completionHandler(.success(wordModel))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func save(word: CDWordEntity, completionHandler: @escaping MDCDResultSavedWord) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.readWord(fromUUID: word.uuid!) { [unowned self] (result) in
                    switch result {
                    case .success(let wordModel):
                        completionHandler(.success(wordModel))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
