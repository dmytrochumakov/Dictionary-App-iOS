//
//  CourseListTableViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import MGSwipeTableCell

protocol CourseListTableViewDataSourceProtocol: UITableViewDataSource {
    var deleteButtonAction: ((MDCourseListCell) -> Void)? { get set }
}

final class CourseListTableViewDataSource: NSObject,
                                           CourseListTableViewDataSourceProtocol {
    
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    public var deleteButtonAction: ((MDCourseListCell) -> Void)?
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MDCourseListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillWithModel(dataProvider.courseListCellModel(atIndexPath: indexPath))
        let deleteButton: MGSwipeButton = .init(title: MDConstants.StaticText.emptyString,
                                                icon: MDAppStyling.Image.delete.image,
                                                backgroundColor: MDAppStyling.Color.md_FFFFFF.color()) { [weak self] (sender) -> Bool in
            
            self?.deleteButtonAction?(sender as! MDCourseListCell)
            
            return true
            
        }
        cell.rightButtons = [deleteButton]
        return cell
    }
    
}
