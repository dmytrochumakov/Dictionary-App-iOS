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
        
        let memoryStorage: MDCourseMemoryStorageProtocol = MDCourseMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseMemoryStorageOperationQueue)!,
                                                                                      array: .init())
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack.init()
        
        let coreDataStorage: MDCourseCoreDataStorageProtocol = MDCourseCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue)!,
                                                                                            managedObjectContext: coreDataStack.privateContext,
                                                                                            coreDataStack: coreDataStack)
        
        let courseStorage: MDCourseStorageProtocol = MDCourseStorage.init(memoryStorage: memoryStorage,
                                                                          coreDataStorage: coreDataStorage,
                                                                          operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseStorageOperationQueue)!)
        
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
                    
                    if (resultCount == createResults.count) {
                        expectation.fulfill()
                    }
                    
                case .failure(let error):
                    XCTExpectFailure(error.localizedDescription)
                    expectation.fulfill()
                }
                
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Create_Courses_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create Courses In All Expectation")
        let storageType: MDStorageType = .all
        
        var resultCount: Int = .zero
        
        courseStorage.createCourses(storageType: storageType,
                                    courseEntities: Constants_For_Tests.mockedCourses) { createResults in
            
            createResults.forEach { createResult in
                
                switch createResult.result {
                case .success(let createdCourseEntities):
                    
                    resultCount += 1
                    
                    XCTAssertTrue(createdCourseEntities.count == Constants_For_Tests.mockedCourses.count)
                    
                    if (resultCount == createResults.count) {
                        expectation.fulfill()
                    }
                    
                case .failure(let error):
                    XCTExpectFailure(error.localizedDescription)
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
                            
                            if (resultCount == readResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
                    }
                    
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
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
                                                fromCourseId: createCourseEntity.courseId) { deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                            
                        case .success:
                            
                            resultCount += 1
                            
                            if (resultCount == deleteResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
                    }
                }
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
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
                
                self.courseStorage.deleteAllCourses(storageType: storageType) { deleteResults in
                    
                    deleteResults.forEach { deleteResult in
                        
                        switch deleteResult.result {
                            
                        case .success:
                            
                            resultCount += 1
                            
                            if (resultCount == deleteResults.count) {
                                expectation.fulfill()
                            }
                            
                        case .failure(let error):
                            XCTExpectFailure(error.localizedDescription)
                            expectation.fulfill()
                        }
                        
                    }
                }
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
