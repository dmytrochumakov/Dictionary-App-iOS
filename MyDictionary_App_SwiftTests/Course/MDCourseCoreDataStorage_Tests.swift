//
//  MDCourseCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDCourseCoreDataStorage_Tests: XCTestCase {
    
    fileprivate var courseCoreDataStorage: MDCourseCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let operationQueue: OperationQueue = .init()
        let operationQueueService: OperationQueueServiceProtocol = OperationQueueService.init(operationQueue: operationQueue)
        
        let coreDataStack: CoreDataStack = TestCoreDataStack()
        
        let courseCoreDataStorage: MDCourseCoreDataStorageProtocol = MDCourseCoreDataStorage.init(operationQueueService: operationQueueService,
                                                                                                  managedObjectContext: coreDataStack.privateContext,
                                                                                                  coreDataStack: coreDataStack)
        
        self.courseCoreDataStorage = courseCoreDataStorage
        
    }
    
}

extension MDCourseCoreDataStorage_Tests {
    
    func test_Create_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create Course Expectation")
        
        courseCoreDataStorage.createCourse(Constants_For_Tests.mockedCourse) { createResult in
            
            switch createResult {
            
            case .success(let courseEntity):
                
                XCTAssertTrue(courseEntity.userId == Constants_For_Tests.mockedCourse.userId)
                XCTAssertTrue(courseEntity.courseId == Constants_For_Tests.mockedCourse.courseId)
                XCTAssertTrue(courseEntity.languageId == Constants_For_Tests.mockedCourse.languageId)
                XCTAssertTrue(courseEntity.languageName == Constants_For_Tests.mockedCourse.languageName)
                XCTAssertTrue(courseEntity.createdAt == Constants_For_Tests.mockedCourse.createdAt)
                
                expectation.fulfill()
                
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Read_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read Course Expectation")
        
        courseCoreDataStorage.createCourse(Constants_For_Tests.mockedCourse) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createCourseEntity):
                
                courseCoreDataStorage.readCourse(fromCourseId: createCourseEntity.courseId) { readResult in
                    
                    switch readResult {
                    
                    case .success(let readCourseEntity):
                        
                        XCTAssertTrue(readCourseEntity.userId == createCourseEntity.userId)
                        XCTAssertTrue(readCourseEntity.courseId == createCourseEntity.courseId)
                        XCTAssertTrue(readCourseEntity.languageId == createCourseEntity.languageId)
                        XCTAssertTrue(readCourseEntity.languageName == createCourseEntity.languageName)
                        XCTAssertTrue(readCourseEntity.createdAt == createCourseEntity.createdAt)
                        
                        expectation.fulfill()
                        
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
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete Course Expectation")
        
        courseCoreDataStorage.createCourse(Constants_For_Tests.mockedCourse) { [unowned self] createResult in
            
            switch createResult {
            
            case .success(let createCourseEntity):
                
                courseCoreDataStorage.deleteCourse(fromCourseId: createCourseEntity.courseId) { [unowned self] deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
                        self.courseCoreDataStorage.entitiesIsEmpty { entitiesIsEmptyResult in
                            
                            switch entitiesIsEmptyResult {
                            
                            case .success(let entitiesIsEmpty):
                                
                                XCTAssertTrue(entitiesIsEmpty)
                                expectation.fulfill()
                                
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
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
    func test_Delete_All_Courses_Functionality() {
        
        let expectation = XCTestExpectation(description: "Delete All Courses Expectation")
        
        courseCoreDataStorage.createCourse(Constants_For_Tests.mockedCourse) { [unowned self] createResult in
            
            switch createResult {
            
            case .success:
                
                courseCoreDataStorage.deleteAllCourses() { [unowned self] deleteResult in
                    
                    switch deleteResult {
                    
                    case .success:
                        
                        self.courseCoreDataStorage.entitiesIsEmpty { entitiesIsEmptyResult in
                            
                            switch entitiesIsEmptyResult {
                            
                            case .success(let entitiesIsEmpty):
                                
                                XCTAssertTrue(entitiesIsEmpty)
                                expectation.fulfill()
                                
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
            case .failure:
                XCTExpectFailure()
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
