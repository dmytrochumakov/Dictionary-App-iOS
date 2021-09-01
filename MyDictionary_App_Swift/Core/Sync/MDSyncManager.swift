//
//  MDSyncManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 01.09.2021.
//

import Foundation

protocol MDSyncManagerProtocol {
    var isRunning: Bool { get }
    func start(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
}

final class MDSyncManager: MDSyncManagerProtocol {
    
    fileprivate let sync: MDSyncProtocol
    
    // Default is false
    fileprivate var internalIsRunning: Bool
    
    public var isRunning: Bool {
        return self.internalIsRunning
    }
    
    init(sync: MDSyncProtocol) {
        self.internalIsRunning = false
        self.sync = sync
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    func start(withSyncItem item: MDSync.Item, completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        // Check Is Sync Not Running
        guard !isRunning else { return }
        
        // Set In Running
        setInternalIsRunningTrue()
        
        // Initialize Count Result
        var countResult: Int = .zero
        
        // Start Sync
        sync.startWitDeleteAllData(withSyncItem: item) { [unowned self] results in
            
            results.forEach { result in
                
                debugPrint(#function, Self.self, "step: ", result.syncStep)
                
                switch result.result {
                
                case .success:
                    //
                    debugPrint(#function, Self.self, "step: ", result.syncStep, "Success")
                    //
                    countResult += 1
                    //
                    if (countResult == results.count) {
                        //
                        setInternalIsRunningFalse()
                        //
                        completionHandler(.success(()))
                        //
                        break
                        //
                    }
                //
                case .failure(let error):
                    //
                    debugPrint(#function, Self.self, "step: ", result.syncStep, "Failure: ", error)
                    //
                    setInternalIsRunningFalse()
                    //
                    completionHandler(.failure(error))
                    //
                    return
                }
            }
            
        }
        
    }
    
    fileprivate func setInternalIsRunning(_ newValue: Bool) {
        self.internalIsRunning = newValue
    }
    
    fileprivate func setInternalIsRunningTrue() {
        self.setInternalIsRunning(true)
    }
    
    fileprivate func setInternalIsRunningFalse() {
        self.setInternalIsRunning(false)
    }
    
}
