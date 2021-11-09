//
//  MDFilterSearchTextService.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 07.10.2021.
//

import Foundation

protocol MDTextForSearchWithOnePropertyProtocol {
    var textForSearch: String { get }
}

protocol MDTextForSearchWithTwoPropertiesProtocol {
    var textForSearch0: String { get }
    var textForSearch1: String { get }
}

protocol MDFilterSearchTextServiceProtocol {
    
    func filter(input: [MDTextForSearchWithOnePropertyProtocol],
                searchText: String?,
                _ completionHandler: @escaping(([MDTextForSearchWithOnePropertyProtocol]) -> Void))
    
    func filter(input: [MDTextForSearchWithTwoPropertiesProtocol],
                searchText: String?,
                _ completionHandler: @escaping(([MDTextForSearchWithTwoPropertiesProtocol]) -> Void))
    
}

final class MDFilterSearchTextService: NSObject,
                                       MDFilterSearchTextServiceProtocol {
    
    fileprivate let operationQueue: OperationQueue
    
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
    
    func filter(input: [MDTextForSearchWithOnePropertyProtocol],
                searchText: String?,
                _ completionHandler: @escaping(([MDTextForSearchWithOnePropertyProtocol]) -> Void)) {
        
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
    
    func filter(input: [MDTextForSearchWithTwoPropertiesProtocol],
                searchText: String?,
                _ completionHandler: @escaping(([MDTextForSearchWithTwoPropertiesProtocol]) -> Void)) {
        
        let operation: BlockOperation = .init {
            
            //
            if (MDConstants.Text.textIsEmpty(searchText)) {
                
                //
                completionHandler(input)
                //
                
            } else {
                
                //
                completionHandler(input.filter({ $0.textForSearch0.lowercased().contains(searchText!.lowercased()) || $0.textForSearch1.lowercased().contains(searchText!.lowercased()) }))
                //
                
            }
            //
            
        }
        
        // Add Operation
        operationQueue.addOperation(operation)
        //
        
    }
    
}
