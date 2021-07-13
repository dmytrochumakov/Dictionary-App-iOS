//
//  OperationQueueService_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class OperationQueueService_Tests: XCTestCase {
    
    fileprivate var operationQueueService: OperationQueueServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        
        self.operationQueueService = OperationQueueService.init(operationQueue: operationQueue)
        
    }
    
}

extension OperationQueueService_Tests {
    
    func test_Enqueue_One_Operation() {
        operationQueueService.enqueue(.init())
        XCTAssertTrue(operationQueueService.operationCount == 1)
    }
    
    func test_Cancel_All_Operations() {
        operationQueueService.enqueue(.init())
        XCTAssertTrue(operationQueueService.operationCount == 1)
        operationQueueService.cancelAllOperations()
        debugPrint(Self.self, #function, "operationQueueService.operationCount:", operationQueueService.operationCount)
        XCTAssertTrue(operationQueueService.operationCount == .zero)
    }
    
}
