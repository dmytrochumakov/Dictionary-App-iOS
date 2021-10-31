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
    
    func updateWordInApiAndAllStorage(courseId: Int64,
                                      wordId: Int64,
                                      languageId: Int64,
                                      newWordText: String,
                                      newWordDescription: String,
                                      languageName: String,
                                      _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>))
    
    func deleteWordFromApiAndAllStorage(byUserId userId: Int64,
                                        byCourseId courseId: Int64,
                                        byWordId wordId: Int64,
                                        _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDWordManager: MDWordManagerProtocol {
    
    fileprivate let apiWord: MDAPIWordProtocol
    fileprivate let wordStorage: MDWordStorageProtocol
    
    init(apiWord: MDAPIWordProtocol,
         wordStorage: MDWordStorageProtocol) {
        
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
        
        
    }
    
}

extension MDWordManager {
    
    func updateWordInApiAndAllStorage(courseId: Int64,
                                      wordId: Int64,
                                      languageId: Int64,
                                      newWordText: String,
                                      newWordDescription: String,
                                      languageName: String,
                                      _ completionHandler: @escaping (MDOperationResultWithCompletion<WordResponse>)) {
        
        
    }
    
}

extension MDWordManager {
    
    func deleteWordFromApiAndAllStorage(byUserId userId: Int64,
                                        byCourseId courseId: Int64,
                                        byWordId wordId: Int64,
                                        _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        
    }
    
}
