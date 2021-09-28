//
//  MDWordManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 26.09.2021.
//

import Foundation

protocol MDWordManagerProtocol {
    
    func addWord(courseId: Int64,
                 languageId: Int64,
                 wordText: String,
                 wordDescription: String,
                 languageName: String,
                 _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>))
    
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
    
    func addWord(courseId: Int64,
                 languageId: Int64,
                 wordText: String,
                 wordDescription: String,
                 languageName: String,
                 _ completionHandler: @escaping (MDOperationResultWithCompletion<WordResponse>)) {
        
        var resultCount: Int = .zero
        
        jwtManager.fetchUserAndJWT { [unowned self] fetchUserAndJWTResult in
            
            switch fetchUserAndJWTResult {
                
            case .success(let userAndJWT):
                
                apiWord.createWord(accessToken: userAndJWT.jwt.accessToken,
                                   createWordRequest: .init(userId: userAndJWT.user.userId,
                                                            courseId: courseId,
                                                            languageId: languageId,
                                                            wordText: wordText,
                                                            wordDescription: wordDescription,
                                                            languageName: languageName)) { [unowned self] createApiWordResult in
                    
                    switch createApiWordResult {
                        
                    case .success(let wordResponse):
                        
                        wordStorage.createWord(wordResponse,
                                               storageType: .all) { createStorageWordResults in
                            
                            createStorageWordResults.forEach { createStorageWordResult in
                                
                                switch createStorageWordResult.result {
                                    
                                case .success:
                                    
                                    //
                                    resultCount += 1
                                    //
                                    
                                    if (resultCount == createStorageWordResults.count) {
                                        //
                                        completionHandler(.success(wordResponse))
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
                        break
                        
                    case .failure(let error):
                        
                        //
                        completionHandler(.failure(error))
                        //
                        break
                        //
                        
                    }
                    
                }
                
                break
                
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
