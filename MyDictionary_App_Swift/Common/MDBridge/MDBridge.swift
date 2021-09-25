//
//  MDBridge.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.09.2021.
//

import Foundation

protocol MDBridgeProtocol {
    var didSelectCourse: ((MDAddCourseRow) -> Void)? { get set }
}

final class MDBridge: MDBridgeProtocol {
    
    public var didSelectCourse: ((MDAddCourseRow) -> Void)?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
