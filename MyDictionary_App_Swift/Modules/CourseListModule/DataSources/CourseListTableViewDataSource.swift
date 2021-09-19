//
//  CourseListTableViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListTableViewDataSourceProtocol: UITableViewDataSource {
    
}

final class CourseListTableViewDataSource: NSObject,
                                                CourseListTableViewDataSourceProtocol {
    
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListTableViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MDCourseListCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.fillWithModel(dataProvider.courseListCellModel(atIndexPath: indexPath))
        return cell
    }
    
}
