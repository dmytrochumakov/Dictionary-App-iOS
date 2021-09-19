//
//  CourseListTableViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListTableViewDelegateProtocol: UITableViewDelegate {
    
}

final class CourseListTableViewDelegate: NSObject, CourseListTableViewDelegateProtocol {
    
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListTableViewDelegate {            
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MDCourseListCell.height
    }
    
}
