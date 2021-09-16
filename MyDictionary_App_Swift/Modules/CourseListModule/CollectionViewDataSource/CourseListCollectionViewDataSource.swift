//
//  CourseListCollectionViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListCollectionViewDataSourceProtocol: CollectionViewDataSource {
    
}

final class CourseListCollectionViewDataSource: NSObject,
                                                CourseListCollectionViewDataSourceProtocol {
    
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseListCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.fillWithModel(dataProvider.courseListCellModel(atIndexPath: indexPath))
        return cell
    }
    
}
