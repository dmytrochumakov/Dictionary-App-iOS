//
//  CourseListTableViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListTableViewDelegateProtocol: TableViewDelegate {
    
}

final class CourseListTableViewDelegate: NSObject, CourseListTableViewDelegateProtocol {
 
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListTableViewDelegate {            
    
}
