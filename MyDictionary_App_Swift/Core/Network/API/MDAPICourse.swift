//
//  MDAPICourse.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import Foundation

protocol MDAPICourseProtocol {
    
    func createCourse(accessToken: String,
                      createCourseRequest: CreateCourseRequest,
                      completionHandler: @escaping(MDOperationResultWithCompletion<CourseResponse>))
    
    func getCourses(accessToken: String,
                    byUserId userId: Int64,
                    completionHandler: @escaping(MDOperationsResultWithCompletion<CourseResponse>))
    
    func deleteCourse(accessToken: String,
                      userId: Int64,
                      courseId: Int64,
                      completionHandler: @escaping(MDOperationResultWithCompletion<Void>))
    
}

final class MDAPICourse: MDAPICourseProtocol {
    
    fileprivate let requestDispatcher: MDRequestDispatcherProtocol
    fileprivate let operationQueueService: OperationQueueServiceProtocol
    
    init(requestDispatcher: MDRequestDispatcherProtocol,
         operationQueueService: OperationQueueServiceProtocol) {
        
        self.requestDispatcher = requestDispatcher
        self.operationQueueService = operationQueueService
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAPICourse {
    
    enum MDAPICourseEndpoint: MDEndpoint {
        
        case getCourses(accessToken: String,
                        userId: Int64)
        
        case createCourse(accessToken: String,
                          createCourseRequest: CreateCourseRequest)
        
        case deleteCourse(accessToken: String,
                          userId: Int64,
                          courseId: Int64)
        
        var path: String {
            switch self {
            case .getCourses(_ , let userID):
                return "courses/userId/\(userID)"
            case .createCourse:
                return "courses"
            case .deleteCourse(_,
                               let userId,
                               let courseId):
                return "courses/userId/\(userId)/courseId/\(courseId)"
            }
        }
        
        var httpMethod: HTTPMethod {
            switch self {
            case .getCourses:
                return .get
            case .createCourse:
                return .post
            case .deleteCourse:
                return .delete
            }
        }
        
        var httpHeaders: HTTPHeader {
            switch self {
            case .getCourses(let accessToken, _),
                 .createCourse(let accessToken, _ ),
                 .deleteCourse(let accessToken, _, _):
                return MDConstants
                    .HTTPHeaderConstants
                    .authorizationHeaders(accessToken: accessToken)
            }
        }
        
        var httpParameters: HTTPParameters? {
            switch self {
            case .getCourses,
                 .deleteCourse:
                return nil
            case .createCourse(_, let createCourseRequest):
                return createCourseRequest.data
            }
        }
        
        var requestType: MDRequestType {
            switch self {
            case .getCourses,
                 .createCourse,
                 .deleteCourse:
                return .data
            }
        }
        
        var responseType: MDResponseType {
            switch self {
            case .getCourses,
                 .createCourse,
                 .deleteCourse:
                return .data
            }
        }
        
    }
    
}

extension MDAPICourse {
    
    func createCourse(accessToken: String,
                      createCourseRequest: CreateCourseRequest,
                      completionHandler: @escaping (MDOperationResultWithCompletion<CourseResponse>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPICourseEndpoint.createCourse(accessToken: accessToken,
                                                                                         createCourseRequest: createCourseRequest)) { result in
            
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode(CourseResponse.self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
            
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func getCourses(accessToken: String,
                    byUserId userId: Int64,
                    completionHandler: @escaping(MDOperationsResultWithCompletion<CourseResponse>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPICourseEndpoint.getCourses(accessToken: accessToken,
                                                                                       userId: userId)) { result in
            
            switch result {
            
            case .data(let data, _):
                
                guard let data = data else { completionHandler(.failure(MDAPIError.noData)) ; return }
                
                debugPrint(#function, Self.self, "dataCount: ", data.count)
                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode([CourseResponse].self, from: data)))
                } catch (_) {
                    completionHandler(.failure(MDAPIError.parseError))
                }
                
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
            
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
    func deleteCourse(accessToken: String,
                      userId: Int64,
                      courseId: Int64,
                      completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        let operation: MDAPIOperation = .init(requestDispatcher: self.requestDispatcher,
                                              endpoint: MDAPICourseEndpoint.deleteCourse(accessToken: accessToken,
                                                                                         userId: userId,
                                                                                         courseId: courseId)) { result in
            
            switch result {
            
            case .data:
                
                completionHandler(.success(()))
                break
                
            case .error(let error, _):
                
                debugPrint(#function, Self.self, "error: ", error.localizedDescription)
                
                completionHandler(.failure(error))
                
                break
                
            }
            
        }
        
        operationQueueService.enqueue(operation)
        
    }
    
}
