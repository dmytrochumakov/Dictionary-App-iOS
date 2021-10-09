//
//  MDSyncManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 01.09.2021.
//

import Foundation

protocol MDSyncManagerProtocol {
    
    var isRunning: Bool { get }
    
    func startFullSync(withSyncItem item: MDSync.Item,
                       progressCompletionHandler: @escaping(MDProgressWithCompletion),
                       completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
    func startWithJWTAndUserAndLanguageSync(withSyncItem item: MDSync.Item,
                                            progressCompletionHandler: @escaping(MDProgressWithCompletion),
                                            completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
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
    
}

extension MDSyncManager {
    
    func startFullSync(withSyncItem item: MDSync.Item,
                       progressCompletionHandler: @escaping(MDProgressWithCompletion),
                       completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        // Check Is Sync Not Running
        guard !self.isRunning else { completionHandler(.failure(MDSyncError.syncIsRunning)) ; return }
        
        // Set In Running
        self.setInternalIsRunningTrue()
        
        // Initialize Count Result
        var countResult: Int = .zero
        
        // Start Sync
        self.sync.startFullSyncWithDeleteAllData(withSyncItem: item) { progress in
            progressCompletionHandler(progress)
        } completionHandler: { [unowned self] results in
            
            results.forEach { result in
                
                debugPrint(#function, Self.self, "step: ", result.storageServiceType)
                
                switch result.result {
                    
                case .success:
                    //
                    debugPrint(#function, Self.self, "step: ", result.storageServiceType, "Success")
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
                    debugPrint(#function, Self.self, "step: ", result.storageServiceType, "Failure: ", error)
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
    
    func startWithJWTAndUserAndLanguageSync(withSyncItem item: MDSync.Item,
                                            progressCompletionHandler: @escaping(MDProgressWithCompletion),
                                            completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        // Check Is Sync Not Running
        guard !self.isRunning else { completionHandler(.failure(MDSyncError.syncIsRunning)) ; return }
        
        // Set In Running
        self.setInternalIsRunningTrue()
        
        // Initialize Count Result
        var countResult: Int = .zero
        
        // Start Sync
        self.sync.startWithJWTAndUserAndLanguageSync(withSyncItem: item) { progress in
            
            // Pass Progress
            progressCompletionHandler(progress)
            
        } completionHandler: { [unowned self] (results) in
            
            results.forEach { result in
                
                debugPrint(#function, Self.self, "step: ", result.storageServiceType)
                
                switch result.result {
                    
                case .success:
                    //
                    debugPrint(#function, Self.self, "step: ", result.storageServiceType, "Success")
                    // Increment count Result
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
                    debugPrint(#function, Self.self, "step: ", result.storageServiceType, "Failure: ", error)
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
    
}

fileprivate extension MDSyncManager {
    
    func setInternalIsRunning(_ newValue: Bool) {
        self.internalIsRunning = newValue
    }
    
    func setInternalIsRunningTrue() {
        self.setInternalIsRunning(true)
    }
    
    func setInternalIsRunningFalse() {
        self.setInternalIsRunning(false)
    }
    
}
