//
//  MDUpdateJWTMemoryStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.08.2021.
//

import Foundation

final class MDUpdateJWTMemoryStorageOperation: MDOperation {

    fileprivate let memoryStorage: MDJWTMemoryStorage
    fileprivate let oldAccessToken: String
    fileprivate let newJWTResponse: JWTResponse
    fileprivate let result: MDOperationResultWithCompletion<Void>?

    init(memoryStorage: MDJWTMemoryStorage,
         oldAccessToken: String,
         newJWTResponse: JWTResponse,
         result: MDOperationResultWithCompletion<Void>?) {

        self.memoryStorage = memoryStorage
        self.oldAccessToken = oldAccessToken
        self.newJWTResponse = newJWTResponse
        self.result = result

        super.init()
    }

    override func main() {
        guard let index = self.memoryStorage.array.firstIndex(where: { $0.accessToken == self.oldAccessToken })
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.memoryStorage.array[index] = self.newJWTResponse
        self.result?(.success(()))
        self.finish()
    }

    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }

}
