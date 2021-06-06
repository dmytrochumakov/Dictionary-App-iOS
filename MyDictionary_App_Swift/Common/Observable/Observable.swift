//
//  Observable.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import Foundation

final class Observable<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    fileprivate let accessQueue: DispatchQueue
    fileprivate var observers: [ObjectIdentifier : CompletionHandler]
    fileprivate var value: T
    
    init(value: T,
         accessQueue: DispatchQueue = .init(label: ("MDObservable_Dispatch_Queue_Concurrent"),
                                            attributes: .concurrent)) {
        self.value = value
        self.accessQueue = accessQueue
        self.observers = [:]
    }
    
    deinit {
        observers.removeAll()
    }
    
}

// MARK: - Add Observer
extension Observable {
    
    func addObserver(_ observer: AnyObject, completion: @escaping CompletionHandler) {
        let id = ObjectIdentifier(observer)
        self.accessQueue.async(flags: .barrier) {
            self.observers[id] = completion
        }
    }
    
}

// MARK: - Remove Observer
extension Observable {
    
    func removeObserver(_ observer: AnyObject) {
        let id = ObjectIdentifier(observer)
        self.accessQueue.async(flags: .barrier) {
            self.observers.removeValue(forKey: id)
        }
    }        
    
}

// MARK: - Update Value
extension Observable {

    func updateValue(_ newValue: T) {
        self.value = newValue
        self.notifyObservers(self.observers)
    }
    
}

// MARK: - Notify Observers
fileprivate extension Observable {
    
    func notifyObservers(_ observers: [ObjectIdentifier : CompletionHandler]) {
        let observers = {
            self.accessQueue.sync {
                return self.observers
            }
        }
        
        observers().forEach({ $0.value(value) })
    }
    
}
