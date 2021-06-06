//
//  Observable.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import Foundation

protocol Observable {
    func addObserver<T>(_ observer: AnyObject, completion: @escaping MDObservable<T>.CompletionHandler)
    func removeObserver(_ observer: AnyObject)
    func removeObservers(_ observer: AnyObject)
}

final class MDObservable<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    fileprivate let accessQueue: DispatchQueue
    fileprivate var observers: [ObjectIdentifier : CompletionHandler]
    fileprivate var value: T {
        didSet {
            self.notifyObservers(self.observers)
        }
    }
    
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
extension MDObservable {
    
    func addObserver(_ observer: AnyObject, completion: @escaping CompletionHandler) {
        let id = ObjectIdentifier(observer)
        self.accessQueue.async(flags: .barrier) {
            self.observers[id] = completion
        }
    }
    
}

// MARK: - Remove Observer
extension MDObservable {
    
    func removeObserver(_ observer: AnyObject) {
        let id = ObjectIdentifier(observer)
        self.accessQueue.async(flags: .barrier) {
            self.observers.removeValue(forKey: id)
        }
    }
    
    func removeObservers(_ observer: AnyObject) {
        let id = ObjectIdentifier(observer)
        let filterObservers = {
            self.accessQueue.sync {
                return self.observers.filter({ $0.key == id })
            }
        }
        filterObservers().forEach { (id, _) in
            self.accessQueue.async(flags: .barrier) {
                self.observers.removeValue(forKey: id)
            }
        }
    }
    
}

// MARK: - Notify Observers
fileprivate extension MDObservable {
    
    func notifyObservers(_ observers: [ObjectIdentifier : CompletionHandler]) {
        let observers = {
            self.accessQueue.sync {
                return self.observers
            }
        }
        
        observers().forEach({ $0.value(value) })
    }
    
}
