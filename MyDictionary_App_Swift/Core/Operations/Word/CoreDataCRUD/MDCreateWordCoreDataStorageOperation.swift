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
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let word: WordResponse
    fileprivate let result: MDOperationResultWithCompletion<WordResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         word: WordResponse,
         result: MDOperationResultWithCompletion<WordResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newWord = CDWordResponseEntity.init(wordResponse: self.word,
                                                insertIntoManagedObjectContext: self.managedObjectContext)
        
        self.wordStorage.save(wordId: newWord.wordId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdWord):
                    self?.result?(.success(createdWord))
                    self?.finish()
                case .failure(let error):
                    self?.result?(.failure(error))
                    self?.finish()
                }
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
    fileprivate let coreDataStorage: MDWordCoreDataStorage
    fileprivate let words: [WordResponse]
    fileprivate let result: MDOperationsResultWithCompletion<WordResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStorage: MDWordCoreDataStorage,
         words: [WordResponse],
         result: MDOperationsResultWithCompletion<WordResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStorage = coreDataStorage
        self.words = words
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        var resultCount: Int = .zero
        
        self.words.forEach { word in
            
            let newWord = CDWordResponseEntity.init(wordResponse: word,
                                                    insertIntoManagedObjectContext: self.managedObjectContext)
            
            self.coreDataStorage.save(wordId: newWord.wordId) { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success:
                        
                        resultCount += 1
                        
                        if (resultCount == self?.words.count) {
                            self?.result?(.success(self?.words ?? []))
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
