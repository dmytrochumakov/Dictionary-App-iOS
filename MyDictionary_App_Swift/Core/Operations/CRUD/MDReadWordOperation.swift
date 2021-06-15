//
//  MDReadWordOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 29.05.2021.
//

import Foundation

final class MDReadWordOperation: MDWordOperation {
    
    fileprivate let wordStorage: MDWordStorageProtocol
    fileprivate let uuid: UUID
    fileprivate let result: MDReadWordOperationResult?
    
    init(wordStorage: MDWordStorageProtocol,
         uuid: UUID,
         result: MDReadWordOperationResult?) {
        
        self.wordStorage = wordStorage
        self.uuid = uuid
        self.result = result
        
        super.init()
    }
    
    override func main() {
        self.wordStorage.readWord(fromUUID: uuid) { [weak self] result in
            self?.result?(result)
            self?.finish()
        }
    }
    
    deinit {
        debugPrint(Self.self, #function)
        self.finish()
    }

}
