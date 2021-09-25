//
//  MDBridge.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 25.09.2021.
//

import Foundation

protocol MDBridgeProtocol {
    var didSelectCourse: ((CourseResponse) -> Void)? { get set }
}

final class MDBridge: MDBridgeProtocol {
    
    public var didSelectCourse: ((CourseResponse) -> Void)?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
