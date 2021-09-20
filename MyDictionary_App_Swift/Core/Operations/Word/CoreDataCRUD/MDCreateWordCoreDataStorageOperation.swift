//
//  MDCreateWordCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

final class MDCreateWordCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let word: WordResponse
    fileprivate let result: MDOperationResultWithCompletion<WordResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         wordStorage: MDWordCoreDataStorage,
         word: WordResponse,
         result: MDOperationResultWithCompletion<WordResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newWord = CDWordResponseEntity.init(wordResponse: self.word,
                                                insertIntoManagedObjectContext: self.managedObjectContext)
        
        coreDataStack.save(managedObjectContext: managedObjectContext) { [weak self] result in
            
            switch result {
            
            case .success:
                
                self?.result?(.success((newWord.wordResponse)))
                self?.finish()
                break
                
            case .failure(let error):
                
                self?.result?(.failure(error))
                self?.finish()
                break
                
            }
            
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}

final class MDCreateWordsCoreDataStorageOperation: MDOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let coreDataStorage: MDWordCoreDataStorage
    fileprivate let words: [WordResponse]
    fileprivate let result: MDOperationsResultWithCompletion<WordResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         coreDataStorage: MDWordCoreDataStorage,
         words: [WordResponse],
         result: MDOperationsResultWithCompletion<WordResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.words = words
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        if (self.words.isEmpty) {
            self.result?(.success(self.words))
            self.finish()
        } else {
            
            var resultCount: Int = .zero
            
            self.words.forEach { word in
                
                let _ = CDWordResponseEntity.init(wordResponse: word,
                                                  insertIntoManagedObjectContext: self.managedObjectContext)
                
                coreDataStack.save(managedObjectContext: managedObjectContext) { [weak self] result in
                    
                    switch result {
                    
                    case .success:
                        
                        resultCount += 1
                        
                        if (resultCount == self?.words.count) {
                            self?.result?(.success(self?.words ?? []))
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
