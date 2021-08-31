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
    fileprivate let result: MDOperationResultWithCompletion<JWTResponse>?

    init(memoryStorage: MDJWTMemoryStorage,
         oldAccessToken: String,
         newJWTResponse: JWTResponse,
         result: MDOperationResultWithCompletion<JWTResponse>?) {

        self.memoryStorage = memoryStorage
        self.oldAccessToken = oldAccessToken
        self.newJWTResponse = newJWTResponse
        self.result = result

        super.init()
    }

    override func main() {
        guard let jwtResponse = self.memoryStorage.jwtResponse,
              jwtResponse.accessToken == self.oldAccessToken
        else {
            self.result?(.failure(MDEntityOperationError.cantFindEntity));
            self.finish();
            return
        }
        self.memoryStorage.jwtResponse = self.newJWTResponse
        self.result?(.success(self.newJWTResponse))
        self.finish()
    }

    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }

}
