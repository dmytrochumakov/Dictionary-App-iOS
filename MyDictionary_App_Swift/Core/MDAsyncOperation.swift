//
//  MDAsyncOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDOperationProtocol {
    func finish()
}

open class MDAsyncOperation: Operation,
                             MDOperationProtocol {
    
    fileprivate let lockQueue = DispatchQueue(label: MDConstants.QueueName.asyncOperation,
                                              attributes: .concurrent)
    
    fileprivate var _isExecuting: Bool = false
    open override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    fileprivate var _isFinished: Bool = false
    open override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override open var isAsynchronous: Bool {
        return true
    }
    
    open override func start() {
        //
        guard !isCancelled else {
            finish()
            return
        }
        //
        isFinished = false
        //
        isExecuting = true
        //
        main()
        //
    }
    
    open override func cancel() {
        super.cancel()
        finish()
    }
    
    open override func main() {
        fatalError("Subclasses must implement `main` without overriding super.")
    }
    
}

extension MDAsyncOperation {
    
    func finish() {
        //
        isExecuting = false
        //
        isFinished = true
        //
    }
    
}
