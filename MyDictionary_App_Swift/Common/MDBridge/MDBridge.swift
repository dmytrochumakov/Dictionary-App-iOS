//
//  MDBridge.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.09.2021.
//

import Foundation

protocol MDBridgeProtocol {
    var didAddCourse: ((CourseResponse) -> Void)? { get set }
    var didChangeMemoryIsFilledResult: (((MDOperationResultWithoutCompletion<Void>)) -> Void)? { get set }
}

final class MDBridge: MDBridgeProtocol {
    
    public var didAddCourse: ((CourseResponse) -> Void)?
    public var didChangeMemoryIsFilledResult: (((MDOperationResultWithoutCompletion<Void>)) -> Void)? 
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
