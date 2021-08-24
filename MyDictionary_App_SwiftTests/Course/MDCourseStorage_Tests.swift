//
//  MDCourseStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDCourseStorage_Tests: XCTestCase {
    
    fileprivate var courseStorage: MDCourseStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let memoryStorage: MDCourseMemoryStorageProtocol = MDCourseMemoryStorage.init(operationQueueService: operationQueueService,
                                                                                      array: .init())
        
        let coreDataStack: CoreDataStack = TestCoreDataStack.init()
        
        let coreDataStorage: MDCourseCoreDataStorageProtocol = MDCourseCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        
        let courseStorage: MDCourseStorageProtocol = MDCourseStorage.init(memoryStorage: memoryStorage,
                                                                          coreDataStorage: coreDataStorage)
        
        self.courseStorage = courseStorage
        
    }
    
}

// MARK: - All CRUD
extension MDCourseStorage_Tests {
    
    func test_Create_Course_In_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create Course In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        courseStorage.createCourse(storageType: storageType,
                                   courseEntity: Constants_For_Tests.mockedCourse) { createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                case .success(let createdCourseEntity):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createdCourseEntity.userId == Constants_For_Tests.mockedCourse.userId)
                    XCTAssertTrue(createdCourseEntity.courseId == Constants_For_Tests.mockedCourse.courseId)
                    XCTAssertTrue(createdCourseEntity.languageId == Constants_For_Tests.mockedCourse.languageId)
                    XCTAssertTrue(createdCourseEntity.languageName == Constants_For_Tests.mockedCourse.languageName)
                    XCTAssertTrue(createdCourseEntity.createdAt == Constants_For_Tests.mockedCourse.createdAt)
                    XCTAssertTrue(createdCourseEntity.updatedAt == Constants_For_Tests.mockedCourse.updatedAt)
                    
                    if (resultCount == createResults.count) {
                        expectation.fulfill()
                    }
                    
                case .failure:
                    XCTExpectFailure()
                    expectation.fulfill()
                }
                
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_Course_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read Course From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        courseStorage.createCourse(storageType: storageType,
                                   courseEntity: Constants_For_Tests.mockedCourse) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createCourseEntity):
                
                courseStorage.readCourse(storageType: storageType,
                                         fromCourseId: createCourseEntity.courseId) { readResults in
                    
                    readResults.forEach { readResult in
                        
                        switch readResult.result {
                        
                        case .success(let readCourseEntity):
                            
                            resultCount += 1
                            
                            XCTAssertTrue(readCourseEntity.userId == createCourseEntity.userId)
                            XCTAssertTrue(readCourseEntity.courseId == createCourseEntity.courseId)
                            XCTAssertTrue(readCourseEntity.languageId == createCourseEntity.languageId)
                            XCTAssertTrue(readCourseEntity.languageName == createCourseEntity.languageName)
                            XCTAssertTrue(readCourseEntity.createdAt == createCourseEntity.createdAt)
                            XCTAssertTrue(readCourseEntity.updatedAt == createCourseEntity.updatedAt)
                            
                            if (resultCount == readResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure:
                            XCTExpectFailure()
                            expectation.fulfill()
                        }
                        
                    }
                    
                }
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_Course_From_All_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete Course From All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        courseStorage.createCourse(storageType: storageType,
                                   courseEntity: Constants_For_Tests.mockedCourse) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success(let createCourseEntity):
                
                self.courseStorage.deleteCourse(storageType: storageType,
                                                fromCourseId: createCourseEntity.courseId) { [unowned self] deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                        
                        case .success:
                            
                            self.courseStorage.entitiesIsEmpty(storageType: deleteResult.storageType) { entitiesIsEmptyResults in
                                
                                switch entitiesIsEmptyResults.first!.result {
                                
                                case .success(let entitiesIsEmpty):
                                    
                                    resultCount += 1
                                    
                                    XCTAssertTrue(entitiesIsEmpty)
                                    
                                    if (resultCount == deleteResults.count) {
                                        expectation.fulfill()
                                    }
                                    
                                case .failure:
                                    XCTExpectFailure()
                                    expectation.fulfill()
                                }
                            }
                            
                        case .failure:
                            XCTExpectFailure()
                            expectation.fulfill()
                        }
                        
                    }
                }
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_All_Courses() {
        
        let expectation = XCTestExpectation(description: "Delete All Courses Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        courseStorage.createCourse(storageType: storageType,
                                   courseEntity: Constants_For_Tests.mockedCourse) { [unowned self] createResults in
            
            switch createResults.first!.result {
            
            case .success:
                
                self.courseStorage.deleteAllCourses(storageType: storageType) { [unowned self] deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                        
                        case .success:
                            
                            self.courseStorage.entitiesIsEmpty(storageType: deleteResult.storageType) { entitiesIsEmptyResult in
                                
                                switch entitiesIsEmptyResult.first!.result {
                                
                                case .success(let entitiesIsEmpty):
                                    
                                    resultCount += 1
                                    
                                    XCTAssertTrue(entitiesIsEmpty)
                                    
                                    if (resultCount == deleteResults.count) {
                                        expectation.fulfill()
                                    }
                                    
                                    
                                case .failure:
                                    XCTExpectFailure()
                                    expectation.fulfill()
                                }
                            }
                        case .failure:
                            XCTExpectFailure()
                            expectation.fulfill()
                        }
                        
                    }
                }
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
