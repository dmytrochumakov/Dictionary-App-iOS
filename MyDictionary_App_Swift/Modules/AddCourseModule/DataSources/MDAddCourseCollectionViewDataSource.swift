//
//  MDAddCourseCollectionViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import UIKit

protocol MDAddCourseCollectionViewDataSourceProtocol: UICollectionViewDataSource {
    
}

final class MDAddCourseCollectionViewDataSource: NSObject,
                                                 MDAddCourseCollectionViewDataSourceProtocol {
    
    fileprivate let dataProvider: AddCourseDataProviderProtocol
    
    init(dataProvider: AddCourseDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAddCourseCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MDAddCourseCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.fillWithModel(dataProvider.addCourseCellModel(atIndexPath: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view: MDAddCourseHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
        view.fillWithModel(dataProvider.addCourseHeaderViewCellModel(atSection: indexPath.section))
        return view
    }
    
}

