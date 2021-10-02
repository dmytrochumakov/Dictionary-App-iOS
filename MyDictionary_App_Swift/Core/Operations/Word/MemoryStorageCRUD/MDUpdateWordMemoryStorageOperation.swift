//
//  MDUpdateWordMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDUpdateWordMemoryStorageOperation: MDAsyncOperation {
    
    fileprivate let wordStorage: MDWordMemoryStorage
    fileprivate let wordId: Int64
    fileprivate let newWordText: String
    fileprivate let newWordDescription: String
    fileprivate let result: MDOperationResultWithCompletion<Void>?
    
    init(wordStorage: MDWordMemoryStorage,
         wordId: Int64,
         newWordText: String,
         newWordDescription: String,
         result: MDOperationResultWithCompletion<Void>?) {
        
        self.wordStorage = wordStorage
        self.wordId = wordId
        self.newWordText = newWordText
        self.newWordDescription = newWordDescription
        self.result = result
        
        super.init()
    }
    
    override func main() {
        guard let index = self.wordStorage.arrayWords.firstIndex(where: { $0.wordId == self.wordId })
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.wordStorage.arrayWords[index].wordText = self.newWordText
        self.wordStorage.arrayWords[index].wordDescription = self.newWordDescription
        self.result?(.success(()))
        self.finish()
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
