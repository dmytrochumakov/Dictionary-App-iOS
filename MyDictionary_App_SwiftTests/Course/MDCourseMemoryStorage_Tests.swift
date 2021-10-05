//
//  MDCourseMemoryStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDCourseMemoryStorage_Tests: XCTestCase {
    
    fileprivate var courseMemoryStorage: MDCourseMemoryStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let courseMemoryStorage: MDCourseMemoryStorageProtocol = MDCourseMemoryStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseMemoryStorageOperationQueue)!,
                                                                                            array: .init())
        
        self.courseMemoryStorage = courseMemoryStorage
        
    }
    
}

extension MDCourseMemoryStorage_Tests {
    
    func test_Create_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create Course Expectation")
        
        courseMemoryStorage.createCourse(Constants_For_Tests.mockedCourse) { createResult in
            
            switch createResult {
                
            case .success(let courseEntity):
                
                XCTAssertTrue(courseEntity.userId == Constants_For_Tests.mockedCourse.userId)
                XCTAssertTrue(courseEntity.courseId == Constants_For_Tests.mockedCourse.courseId)
                XCTAssertTrue(courseEntity.languageId == Constants_For_Tests.mockedCourse.languageId)
                XCTAssertTrue(courseEntity.languageName == Constants_For_Tests.mockedCourse.languageName)
                XCTAssertTrue(courseEntity.createdAt == Constants_For_Tests.mockedCourse.createdAt)
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Create_Courses_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create Courses Expectation")
        
        courseMemoryStorage.createCourses(Constants_For_Tests.mockedCourses) { createResult in
            
            switch createResult {
                
            case .success(let courseEntities):
                
                XCTAssertTrue(courseEntities.count == Constants_For_Tests.mockedCourses.count)
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read Course Expectation")
        
        courseMemoryStorage.createCourse(Constants_For_Tests.mockedCourse) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createCourseEntity):
                
                courseMemoryStorage.readCourse(fromCourseId: createCourseEntity.courseId) { readResult in
                    
                    switch readResult {
                        
                    case .success(let readCourseEntity):
                        
                        XCTAssertTrue(readCourseEntity.userId == createCourseEntity.userId)
                        XCTAssertTrue(readCourseEntity.courseId == createCourseEntity.courseId)
                        XCTAssertTrue(readCourseEntity.languageId == createCourseEntity.languageId)
                        XCTAssertTrue(readCourseEntity.languageName == createCourseEntity.languageName)
                        XCTAssertTrue(readCourseEntity.createdAt == createCourseEntity.createdAt)
                        
                        expectation.fulfill()
                        
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                    
                }
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete Course Expectation")
        
        courseMemoryStorage.createCourse(Constants_For_Tests.mockedCourse) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createCourseEntity):
                
                courseMemoryStorage.deleteCourse(fromCourseId: createCourseEntity.courseId) { [unowned self] deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
                        self.courseMemoryStorage.entitiesIsEmpty { entitiesIsEmptyResult in
                            
                            switch entitiesIsEmptyResult {
                                
                            case .success(let entitiesIsEmpty):
                                
                                XCTAssertTrue(entitiesIsEmpty)
                                expectation.fulfill()
                                
                            case .failure(let error):
                                XCTExpectFailure(error.localizedDescription)
                                expectation.fulfill()
                            }
                        }
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
                    }
                    
                }
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_All_Courses_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete All Courses Expectation")
        
        courseMemoryStorage.createCourse(Constants_For_Tests.mockedCourse) { [unowned self] createResult in
            
            switch createResult {
                
            case .success:
                
                courseMemoryStorage.deleteAllCourses() { [unowned self] deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
                        self.courseMemoryStorage.entitiesIsEmpty { entitiesIsEmptyResult in
                            
                            switch entitiesIsEmptyResult {
                                
                            case .success(let entitiesIsEmpty):
                                
                                XCTAssertTrue(entitiesIsEmpty)
                                expectation.fulfill()
                                
                            case .failure(let error):
                                XCTExpectFailure(error.localizedDescription)
                                expectation.fulfill()
                            }
                        }
                    case .failure(let error):
                        XCTExpectFailure(error.localizedDescription)
                        expectation.fulfill()
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
