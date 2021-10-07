//
//  MDFilterSearchTextService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.10.2021.
//

import Foundation

protocol MDFilterSearchTextServiceProtocol {
    associatedtype FilterInput: MDTextForSearchProtocol
    func filter(input: [FilterInput],
                searchText: String?,
                _ completionHandler: @escaping(([FilterInput]) -> Void))
}

final class MDFilterSearchTextService<T : MDTextForSearchProtocol>: NSObject,
                                                                    MDFilterSearchTextServiceProtocol {
    
    fileprivate let operationQueue: OperationQueue
    
    public typealias FilterInput = T
    
    init(operationQueue: OperationQueue) {
        
        self.operationQueue = operationQueue
        
        super.init()
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Filter
extension MDFilterSearchTextService {
    
    func filter(input: [FilterInput],
                searchText: String?,
                _ completionHandler: @escaping(([FilterInput]) -> Void)) {
        
        let operation: BlockOperation = .init {
            
            //
            if (MDConstants.Text.textIsEmpty(searchText)) {
                
                //
                completionHandler(input)
                //
                
            } else {
                
                //
                completionHandler(input.filter({ $0.textForSearch.lowercased().contains(searchText!.lowercased()) }))
                //
                
            }
            //
            
        }
        
        // Add Operation
        operationQueue.addOperation(operation)
        //
        
    }
    
}
