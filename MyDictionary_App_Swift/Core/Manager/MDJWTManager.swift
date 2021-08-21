//
//  MDJWTManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

protocol MDJWTManagerProtocol {
    func fetchJWT()
}

final class MDJWTManager: MDJWTManagerProtocol {
    
    fileprivate let jwtStorage: MDJWTStorageProtocol
    
    init(jwtStorage: MDJWTStorageProtocol) {
        self.jwtStorage = jwtStorage
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDJWTManager {
    
    func fetchJWT() {
        
        var results: [MDStorageType : JWTResponse] = [ : ]
        
//        jwtStorage.readFirstJWT(storageType: .all) { [weak self] readResult in
//            
//        }
        
    }
    
}
