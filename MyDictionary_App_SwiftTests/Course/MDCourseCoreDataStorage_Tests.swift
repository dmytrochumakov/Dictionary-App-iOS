//
//  MDCourseCoreDataStorage_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import XCTest
import CoreData
@testable import MyDictionary_App_Swift

final class MDCourseCoreDataStorage_Tests: XCTestCase {
    
    fileprivate var managedObjectContext: NSManagedObjectContext!
    fileprivate var courseCoreDataStorage: MDCourseCoreDataStorageProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let coreDataStack: MDCoreDataStack = TestCoreDataStack()
        
        self.managedObjectContext = coreDataStack.privateContext
        
        let courseCoreDataStorage: MDCourseCoreDataStorageProtocol = MDCourseCoreDataStorage.init(operationQueue: Constants_For_Tests.operationQueueManager.operationQueue(byName: MDConstants.QueueName.courseCoreDataStorageOperationQueue)!,
                                                                                                  managedObjectContext: coreDataStack.privateContext,
                                                                                                  coreDataStack: coreDataStack)
        
        self.courseCoreDataStorage = courseCoreDataStorage
        
    }
    
}

extension MDCourseCoreDataStorage_Tests {
    
    func test_Create_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Create Course Expectation")
        
        courseCoreDataStorage.createCourse(uuid: Constants_For_Tests.mockedCourseUUID,
                                           languageId: Constants_For_Tests.mockedCourseLanguageId,
                                           createdAt: Constants_For_Tests.mockedCourseCreatedAt) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdEntity):
                
                XCTAssertTrue(createdEntity.languageId == Constants_For_Tests.mockedCourseLanguageId)
                
                courseCoreDataStorage.readCourse(byCourseUUID: createdEntity.uuid!) { readResult in
                    
                    switch readResult {
                        
                    case .success(let readEntity):
                        
                        XCTAssertTrue(createdEntity.uuid == readEntity.uuid)
                        XCTAssertTrue(createdEntity.languageId == readEntity.languageId)
                        XCTAssertTrue(createdEntity.createdAt == readEntity.createdAt)
                        
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
    func test_Read_Course_Functionality() {
        
        let expectation = XCTestExpectation(description: "Read Course Expectation")
        
        courseCoreDataStorage.createCourse(uuid: Constants_For_Tests.mockedCourseUUID,
                                           languageId: Constants_For_Tests.mockedCourseLanguageId,
                                           createdAt: Constants_For_Tests.mockedCourseCreatedAt) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createCourseEntity):
                
                courseCoreDataStorage.readCourse(byCourseUUID: createCourseEntity.uuid!) { readResult in
                    
                    switch readResult {
                        
                    case .success(let readCourseEntity):
                        
                        XCTAssertTrue(readCourseEntity.uuid == createCourseEntity.uuid)
                        XCTAssertTrue(readCourseEntity.languageId == createCourseEntity.languageId)
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
        
        courseCoreDataStorage.createCourse(uuid: Constants_For_Tests.mockedCourseUUID,
                                           languageId: Constants_For_Tests.mockedCourseLanguageId,
                                           createdAt: Constants_For_Tests.mockedCourseCreatedAt) { [unowned self] createResult in
            
            switch createResult {
                
            case .success(let createdEntity):
                
                courseCoreDataStorage.deleteCourse(byCourseUUID: createdEntity.uuid!) { [unowned self] deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
                        courseCoreDataStorage.exists(byLanguageId: createdEntity.languageId) { existsResult in
                            
                            switch existsResult {
                                
                            case .success(let exists):
                                
                                XCTAssertFalse(exists)
                                
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
        
        courseCoreDataStorage.createCourse(uuid: Constants_For_Tests.mockedCourseUUID,
                                           languageId: Constants_For_Tests.mockedCourseLanguageId,
                                           createdAt: Constants_For_Tests.mockedCourseCreatedAt) { [unowned self] createResult in
            
            switch createResult {
                
            case .success:
                
                courseCoreDataStorage.deleteAllCourses() { [unowned self] deleteResult in
                    
                    switch deleteResult {
                        
                    case .success:
                        
                        courseCoreDataStorage.entitiesIsEmpty { isEmptyResult in
                            
                            switch isEmptyResult {
                                
                            case .success(let isEmpty):
                                
                                XCTAssertTrue(isEmpty)
                                
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
