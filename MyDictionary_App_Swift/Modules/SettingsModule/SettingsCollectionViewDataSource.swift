//
//  SettingsCollectionViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import UIKit

protocol SettingsCollectionViewDataSourceProtocol: UICollectionViewDataSource {
    
}

final class SettingsCollectionViewDataSource: NSObject, SettingsCollectionViewDataSourceProtocol {
    
    fileprivate let dataProvider: SettingsDataProviderProtocol
    
    init(dataProvider: SettingsDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension SettingsCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SettingsCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.fillWithModel(dataProvider.rowModel(atIndexPath: indexPath))
        return cell
    }
    
}
