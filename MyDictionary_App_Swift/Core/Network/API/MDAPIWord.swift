//
//  MDAPIWord.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

protocol MDAPIWordProtocol {
    
    func createWord(accessToken: String,
                    createWordRequest: CreateWordRequest,
                    completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>))
    
    func getWords(accessToken: String,
                  byUserId userId: Int64,
                  completionHandler: @escaping(MDOperationsResultWithCompletion<WordResponse>))
    
    func updateWord(accessToken: String,
                    updateWordRequest: UpdateWordRequest,
                    completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>))
    
    func deleteWord(accessToken: String,
                    userId: Int64,
                    courseId: Int64,
                    wordId: Int64,
                    completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDAPIWord: MDAPIWordProtocol {
    
    fileprivate let requestDispatcher: MDRequestDispatcherProtocol
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    init(requestDispatcher: MDRequestDispatcherProtocol,
         operationQueueService: OperationQueueServiceProtocol) {
        
        self.requestDispatcher = requestDispatcher
        self.operationQueueService = operationQueueService
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Endpoint
extension MDAPIWord {
    
    enum MDAPIWordEndpoint: MDEndpoint {
        
        case createWord(accessToken: String,
                        createWordRequest: CreateWordRequest)
        
        case readAllWords(accessToken: String,
                          userId: Int64)
        
        case updateWord(accessToken: String,
                        updateWordRequest: UpdateWordRequest)
        
        case deleteWord(accessToken: String,
                        userId: Int64,
                        courseId: Int64,
                        wordId: Int64)
        
        var path: String {
            switch self {
            case .createWord:
                return "words"
            case .readAllWords(_, let userId):
                return "words/userId/\(userId)"
            case .updateWord:
                return "words"
            case .deleteWord(_ ,
                             let userId,
                             let courseId,
                             let wordId):
                
                return "words/userId/\(userId)/courseId/\(courseId)/wordId/\(wordId)"
                
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .createWord:
                return .post
            case .readAllWords:
                return .get
            case .updateWord:
                return .put
            case .deleteWord:
                return .delete
            }
        }
        
        var httpHeaders: HTTPHeader {
            
            switch self {
            
            case .createWord(let accessToken, _),
                 .readAllWords(let accessToken, _),
                 .updateWord(let accessToken, _),
                 .deleteWord(let accessToken, _, _, _):
                
                return MDConstants
                    .HTTPHeaderConstants
                    .authorizationHeaders(accessToken: accessToken)
                
            }
            
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .createWord(_ ,
                             let createWordRequest):
                
                return createWordRequest.data
                
            case .readAllWords:
                return nil
            case .updateWord(_,
                             let updateWordRequest):
                
                return updateWordRequest.data
                
            case .deleteWord:
                return nil
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .createWord:
                return .data
            case .readAllWords:
                return .data
            case .updateWord:
                return .data
            case .deleteWord:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .createWord:
                return .data
            case .readAllWords:
                return .data
            case .updateWord:
                return .data
            case .deleteWord:
                return .data
            }
        }
        
    }
    
}

// MARK: - CRUD
extension MDAPIWord {
    
    func createWord(accessToken: String,
                    createWordRequest: CreateWordRequest,
                    completionHandler: @escaping (MDOperationResultWithCompletion<WordResponse>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIWordEndpoint.createWord(accessToken: accessToken,
                                                                                     createWordRequest: createWordRequest)) { result in
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode(WordResponse.self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
            
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func getWords(accessToken: String,
                  byUserId userId: Int64,
                  completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIWordEndpoint.readAllWords(accessToken: accessToken,
                                                                                       userId: userId)) { result in
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode([WordResponse].self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
            
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func updateWord(accessToken: String,
                    updateWordRequest: UpdateWordRequest,
                    completionHandler: @escaping (MDOperationResultWithCompletion<WordResponse>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIWordEndpoint.updateWord(accessToken: accessToken,
                                                                                     updateWordRequest: updateWordRequest)) { result in
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode(WordResponse.self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
            
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func deleteWord(accessToken: String,
                    userId: Int64,
                    courseId: Int64,
                    wordId: Int64,
                    completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPIWordEndpoint.deleteWord(accessToken: accessToken,
                                                                                     userId: userId,
                                                                                     courseId: courseId,
                                                                                     wordId: wordId)) { result in
            switch result {
            
            case .data:
                
                completionHandler(.success(()))
                
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
            
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
}
