//
//  WordListCollectionViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import UIKit

protocol WordListCollectionViewDataSourceProtocol: CollectionViewDataSourceProtocol {
    
}

final class WordListCollectionViewDataSource: NSObject, WordListCollectionViewDataSourceProtocol {
    
    fileprivate let dataProvider: WordListDataProviderProcotol
    
    init(dataProvider: WordListDataProviderProcotol) {
        self.dataProvider = dataProvider
    }
    
}

extension WordListCollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return .init()
    }
    
}
