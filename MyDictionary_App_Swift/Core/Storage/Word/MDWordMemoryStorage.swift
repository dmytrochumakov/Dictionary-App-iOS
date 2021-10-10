//
//  MDMemoryStorage.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.05.2021.
//

import Foundation

protocol MDWordMemoryStorageProtocol: MDCRUDWordProtocol,
                                      MDStorageInterface {
    
}

final class MDWordMemoryStorage: MDWordMemoryStorageProtocol {
    
    fileprivate let operationQueue: OperationQueue
    fileprivate var array: [WordResponse]
    
    init(operationQueue: OperationQueue,
         array: [WordResponse]) {
        
        self.operationQueue = operationQueue
        self.array = array
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Entities
extension MDWordMemoryStorage {
    
    func entitiesCount(_ completionHandler: @escaping (MDEntitiesCountResultWithCompletion)) {
        self.readAllWords() { result in
            switch result {
            case .success(let words):
                completionHandler(.success(words.count))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func entitiesIsEmpty(_ completionHandler: @escaping (MDEntitiesIsEmptyResultWithCompletion)) {
        self.readAllWords() { result in
            switch result {
            case .success(let words):
                completionHandler(.success(words.isEmpty))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

// MARK: - Create
extension MDWordMemoryStorage {
    
    func createWord(_ wordModel: WordResponse,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>)) {
        
        let operation: BlockOperation = .init {
            
            //
            self.array.append(wordModel)
            //
            
            //
            completionHandler(.success(wordModel))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func createWords(_ wordModels: [WordResponse],
                     _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        let operation: BlockOperation = .init {
            
            
            if (wordModels.isEmpty) {
                
                //
                completionHandler(.success(wordModels))
                //
                
                //
                return
                //
                
            } else {
                
                wordModels.forEach { word in
                    //
                    self.array.append(word)
                    //
                }
                
                //
                completionHandler(.success(wordModels))
                //
                
                //
                return
                //
                
            }
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}
// MARK: - Read
extension MDWordMemoryStorage {
    
    func readWord(fromWordID wordId: Int64,
                  _ completionHandler: @escaping(MDOperationResultWithCompletion<WordResponse>)) {
        
        let operation: BlockOperation = .init {
            
            guard let word = self.array.first(where: { $0.wordId == wordId })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            //
            completionHandler(.success(word))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readWords(fetchLimit: Int,
                   fetchOffset: Int,
                   _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        completionHandler(.failure(MDEntityOperationError.cantFindEntity))
        
    }
    
    func readAllWords(_ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        let operation: BlockOperation = .init {
            
            //
            completionHandler(.success(self.array))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func readAllWords(byCourseID courseID: Int64,
                      _ completionHandler: @escaping (MDOperationsResultWithCompletion<WordResponse>)) {
        
        let operation: BlockOperation = .init {
            
            //
            completionHandler(.success(self.array.filter({ $0.courseId == courseID })))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Update
extension MDWordMemoryStorage {
    
    func updateWord(byWordID wordId: Int64,
                    newWordText: String,
                    newWordDescription: String,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            guard let index = self.array.firstIndex(where: { $0.wordId == wordId })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            //
            self.array[index].wordText = newWordText
            //
            
            //
            self.array[index].wordDescription = newWordDescription
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}

// MARK: - Delete
extension MDWordMemoryStorage {
    
    func deleteWord(byWordId wordId: Int64,
                    _ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            guard let index = self.array.firstIndex(where: { $0.wordId == wordId })
            else {
                
                //
                completionHandler(.failure(MDEntityOperationError.cantFindEntity));
                //
                
                //
                return
                //
                
            }
            
            //
            self.array.remove(at: index)
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func deleteAllWords(byCourseId courseId: Int64,
                        _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            //
            self.array.removeAll(where: { $0.courseId == courseId })
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
    func deleteAllWords(_ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: BlockOperation = .init {
            
            //
            self.array.removeAll()
            //
            
            //
            completionHandler(.success(()))
            //
            
            //
            return
            //
            
        }
        
        //
        operationQueue.addOperation(operation)
        //
        
    }
    
}
