//
//  MDCreateWordCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 08.07.2021.
//

import Foundation
import CoreData

final class MDCreateWordCoreDataStorageOperation: MDWordOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let wordStorage: MDWordCoreDataStorage
    fileprivate let word: WordModel
    fileprivate let result: MDCreateWordOperationResult?
    
    init(managedObjectContext: NSManagedObjectContext,
         wordStorage: MDWordCoreDataStorage,
         word: WordModel,
         result: MDCreateWordOperationResult?) {
        
        self.managedObjectContext = managedObjectContext
        self.wordStorage = wordStorage
        self.word = word
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newWord = CDWordEntity.init(wordModel: self.word,
                                        insertIntoManagedObjectContext: self.managedObjectContext)
        
        self.wordStorage.save(word: newWord) { [weak self] result in
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
        debugPrint(Self.self, #function)
        self.finish()
    }
    
    
}
