//
//  MDBridge.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.09.2021.
//

import Foundation

protocol MDBridgeProtocol {
    var didAddCourse: ((MDCourseListModel) -> Void)? { get set }
    var didChangeMemoryIsFilledResult: (((MDOperationResultWithoutCompletion<Void>)) -> Void)? { get set }
    var didAddWord: ((CDWordEntity) -> Void)? { get set }
    var didDeleteWord: ((CDWordEntity) -> Void)? { get set }
    var didUpdateWord: ((CDWordEntity) -> Void)? { get set }
}

final class MDBridge: MDBridgeProtocol {
    
    public var didAddCourse: ((MDCourseListModel) -> Void)?
    public var didChangeMemoryIsFilledResult: (((MDOperationResultWithoutCompletion<Void>)) -> Void)?
    public var didAddWord: ((CDWordEntity) -> Void)?
    public var didDeleteWord: ((CDWordEntity) -> Void)?
    public var didUpdateWord: ((CDWordEntity) -> Void)?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
