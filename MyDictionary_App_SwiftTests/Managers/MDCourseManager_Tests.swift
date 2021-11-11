//
//  MDCourseManager_Tests.swift
//  MyDictionary_App_SwiftTests
//
//  Created by Dmytro Chumakov on 11.11.2021.
//

import XCTest
@testable import MyDictionary_App_Swift

final class MDCourseManager_Tests: XCTestCase {
    
    fileprivate var wordCoreDataStorage: MDWordCoreDataStorageProtocol!
    fileprivate var courseManager: MDCourseManagerProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let wordCoreDataStorage: MDWordCoreDataStorageProtocol = MDConstants.AppDependencies.dependencies.wordCoreDataStorage
        
        let courseManager: MDCourseManagerProtocol = MDCourseManager.init(courseCoreDataStorage: MDConstants.AppDependencies.dependencies.courseCoreDataStorage,
                                                                          deleteAllWordsCourseUUIDService: wordCoreDataStorage)
        
        self.wordCoreDataStorage = wordCoreDataStorage
        self.courseManager = courseManager
        
    }
    
}

extension MDCourseManager_Tests {
    
    func test_Delete_Course_And_Related_Words() {
        
        let expectation = XCTestExpectation(description: "Delete Course And Related Words")
        
        courseManager.createCourse(uuid: Constants_For_Tests.mockedCourseManagerUUID,
                                   languageId: Constants_For_Tests.mockedCourseManagerLanguageId,
                                   createdAt: Constants_For_Tests.mockedCourseManagerCreatedAt) { [unowned self] createCourseResult in
            
            switch createCourseResult {
                
            case .success(let createdCourseEntity):
                
                wordCoreDataStorage.createWord(courseUUID: createdCourseEntity.uuid!,
                                               uuid: Constants_For_Tests.mockedCourseManagerWordUUID,
                                               wordText: Constants_For_Tests.mockedCourseManagerWordText,
                                               wordDescription: Constants_For_Tests.mockedCourseManagerWordDescription,
                                               createdAt: Constants_For_Tests.mockedCourseManagerWordCreatedAt) { [unowned self] createWordResult in
                    
                    switch createWordResult {
                        
                    case .success:
                        
                        courseManager.deleteCourse(byCourseUUID: createdCourseEntity.uuid!) { [unowned self] deleteResult in
                            
                            switch deleteResult {
                                
                            case .success:
                                
                                wordCoreDataStorage.exists(byCourseUUID: createdCourseEntity.uuid!) { existsResult in
                                    
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
                
            case .failure(let error):
                XCTExpectFailure(error.localizedDescription)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: Constants_For_Tests.testExpectationTimeout)
        
    }
    
}
