//
//  MDWordFilterSearchTextService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.10.2021.
//

import Foundation

protocol MDWordFilterSearchTextServiceProtocol {
    
    func filter(input: [WordResponse],
                searchText: String?,
                _ completionHandler: @escaping(([WordResponse]) -> Void))
    
}

final class MDWordFilterSearchTextService: NSObject,
                                           MDWordFilterSearchTextServiceProtocol {
    
    fileprivate let operationQueue: OperationQueue
    
    init(operationQueue: OperationQueue) {
        
        self.operationQueue = operationQueue
        
        super.init()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Filter Words
extension MDWordFilterSearchTextService {
    
    func filter(input: [WordResponse],
                searchText: String?,
                _ completionHandler: @escaping(([WordResponse]) -> Void)) {
        
        let operation: BlockOperation = .init {
            
            //
            if (MDConstants.Text.textIsEmpty(searchText)) {
                
                //
                completionHandler(input)
                //
                
            } else {
                
                //
                completionHandler(input.filter({ $0.wordText.lowercased().contains(searchText!.lowercased()) || $0.wordDescription.lowercased().contains(searchText!.lowercased()) }))
                //
                
            }
            //
            
        }
        
        // Add Operation
        operationQueue.addOperation(operation)
        //
        
    }
    
}
