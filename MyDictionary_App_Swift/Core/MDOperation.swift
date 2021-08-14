//
//  MDOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDOperationProtocol {
    func finish()
}

open class MDOperation: Operation,
                        MDOperationProtocol {
    
    fileprivate enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
    }
    
    fileprivate var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override open var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override open var isExecuting: Bool {
        return state == .executing
    }
    
    override open var isFinished: Bool {
        return state == .finished
    }
    
    override open var isAsynchronous: Bool {
        return true
    }
    
    open override func start() {
        
        guard !isCancelled else {
            finish()
            return
        }
        
        if !isExecuting {
            state = .executing
        }
        
        main()
        
    }
    
    open override func cancel() {
        super.cancel()
        finish()
    }
    
    open override func main() {
        fatalError()
    }
    
}

extension MDOperation {
    
    func finish() {
        if isExecuting {
            state = .finished
        }
    }
    
}
