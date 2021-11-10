//
//  MDWordManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.11.2021.
//

import Foundation

protocol MDWordManagerProtocol: MDCreateWordProtocol {
    
}

final class MDWordManager: MDWordManagerProtocol {
    
    fileprivate let wordCoreDataStorage: MDWordCoreDataStorageProtocol
    
    init(wordCoreDataStorage: MDWordCoreDataStorageProtocol) {
        self.wordCoreDataStorage = wordCoreDataStorage
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Create
extension MDWordManager {
    
    func createWord(courseUUID: UUID,
                    uuid: UUID,
                    wordText: String,
                    wordDescription: String,
                    createdAt: Date,
                    updatedAt: Date,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        wordCoreDataStorage.exists(byCourseUUID: courseUUID,
                                   andWordText: wordText) { [unowned self] existsResult in
            
            switch existsResult {
                
            case .success(let exists):
                
                if (exists) {
                    
                    //
                    completionHandler(.failure(MDWordOperationError.wordExists))
                    //
                    
                    //
                    return
                    //
                    
                } else {
                    
                    wordCoreDataStorage.createWord(courseUUID: courseUUID,
                                                   uuid: uuid,
                                                   wordText: wordText,
                                                   wordDescription: wordDescription,
                                                   createdAt: createdAt,
                                                   updatedAt: updatedAt) { createResult in
                        
                        //
                        completionHandler(createResult)
                        //
                        
                        //
                        return
                        //
                        
                    }
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                //
                completionHandler(.failure(error))
                //
                
                //
                break
                //
                
            }
            
        }
        
    }
    
}
