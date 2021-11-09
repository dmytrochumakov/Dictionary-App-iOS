//
//  CourseListTableViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListTableViewDelegateProtocol: UITableViewDelegate {
    var didSelectCourse: ((MDCourseListModel) -> Void)? { get set }
}

final class CourseListTableViewDelegate: NSObject, CourseListTableViewDelegateProtocol {
    
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    public var didSelectCourse: ((MDCourseListModel) -> Void)?
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListTableViewDelegate {            
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCourse?(dataProvider.course(atIndexPath: indexPath))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MDCourseListCell.height
    }
    
}
