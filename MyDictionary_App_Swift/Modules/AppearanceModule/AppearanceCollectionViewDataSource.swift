//
//  AppearanceCollectionViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import UIKit

protocol AppearanceCollectionViewDataSourceProtocol: UICollectionViewDataSource {
    
}

final class AppearanceCollectionViewDataSource: NSObject,
                                                AppearanceCollectionViewDataSourceProtocol {
    
    fileprivate let dataProvider: AppearanceDataProviderProtocol
    
    init(dataProvider: AppearanceDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension AppearanceCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AppearanceCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.fillWithModel(dataProvider.row(atIndexPath: indexPath))
        return cell
    }
    
}
