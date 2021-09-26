//
//  MDWordManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 26.09.2021.
//

import Foundation

protocol MDWordManagerProtocol {
    
    func deleteWordFromApiAndAllStorage(byUserId userId: Int64,
                                        byCourseId courseId: Int64,
                                        byWordId wordId: Int64,
                                        _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDWordManager: MDWordManagerProtocol {
    
    fileprivate let jwtManager: MDJWTManagerProtocol
    fileprivate let apiWord: MDAPIWordProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    init(jwtManager: MDJWTManagerProtocol,
         apiWord: MDAPIWordProtocol,
         wordStorage: MDWordStorageProtocol) {
        
        self.jwtManager = jwtManager
        self.apiWord = apiWord
        self.wordStorage = wordStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDWordManager {
    
    func deleteWordFromApiAndAllStorage(byUserId userId: Int64,
                                        byCourseId courseId: Int64,
                                        byWordId wordId: Int64,
                                        _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        var resultCount: Int = .zero
        
        jwtManager.fetchUserAndJWT { [unowned self] fetchUserAndJWTResult in
            
            switch fetchUserAndJWTResult {
                
            case .success(let userAndJWT):
                
                apiWord.deleteWord(accessToken: userAndJWT.jwt.accessToken,
                                   userId: userId,
                                   courseId: courseId,
                                   wordId: wordId) { [unowned self] (apiDeleteWordResult) in
                    
                    switch apiDeleteWordResult {
                        
                    case .success:
                        //
                        wordStorage.deleteWord(byWordId: wordId, storageType: .all) { (storageDeleteWordResults) in
                            
                            storageDeleteWordResults.forEach { storageDeleteWordResult in
                                
                                switch storageDeleteWordResult.result {
                                    
                                case .success:
                                    //
                                    resultCount += 1
                                    //
                                    if (resultCount == storageDeleteWordResults.count) {
                                        //
                                        completionHandler(.success(()))
                                        //
                                        break
                                        //
                                    }
                                    
                                case .failure(let error):
                                    //
                                    completionHandler(.failure(error))
                                    //
                                    break
                                    //
                                }
                                
                            }
                            
                        }
                        
                        //
                    case .failure(let error):
                        //
                        completionHandler(.failure(error))
                        //
                        break
                        //
                    }
                    
                }
                
            case .failure(let error):
                //
                completionHandler(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
}
