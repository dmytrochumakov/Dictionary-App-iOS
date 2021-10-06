//
//  AccountDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import Foundation

protocol AccountDataManagerInputProtocol {
    var dataProvider: AccountDataProviderProtocol { get }
    func loadAndPassUserToDataProvider()
}

protocol AccountDataManagerOutputProtocol: AnyObject {
    func loadAndPassUserToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>)
}

protocol AccountDataManagerProtocol: AccountDataManagerInputProtocol {
    var dataProvider: AccountDataProviderProtocol { get }
    var dataManagerOutput: AccountDataManagerOutputProtocol? { get set }
}

final class AccountDataManager: AccountDataManagerProtocol {
    
    fileprivate let userMemoryStorage: MDUserMemoryStorageProtocol
    internal var dataProvider: AccountDataProviderProtocol
    internal weak var dataManagerOutput: AccountDataManagerOutputProtocol?
    
    init(userMemoryStorage: MDUserMemoryStorageProtocol,
         dataProvider: AccountDataProviderProtocol) {
        
        self.userMemoryStorage = userMemoryStorage
        self.dataProvider = dataProvider
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension AccountDataManager {
    
    func loadAndPassUserToDataProvider() {
        
        userMemoryStorage.readFirstUser { [weak self] result in
            
            switch result {
                
            case .success(let userResponse):
                
                DispatchQueue.main.async {
                    //
                    self?.dataProvider.user = userResponse
                    //
                    self?.dataManagerOutput?.loadAndPassUserToDataProviderResult(.success(()))
                    //
                }
                
                //
                break
                //
                
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    //
                    self?.dataManagerOutput?.loadAndPassUserToDataProviderResult(.failure(error))
                    //
                }
                
                //
                break
                //
                
            }
            
        }
        
    }
    
}
