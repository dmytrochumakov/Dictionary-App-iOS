//
//  TableViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListTableViewDataSourceProtocol: TableViewDataSource {
    
}

final class CourseListTableViewDataSource: NSObject, CourseListTableViewDataSourceProtocol {
    
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
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
        return .init()
    }
    
}
