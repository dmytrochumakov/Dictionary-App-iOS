//
//  WordListCollectionViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import UIKit

protocol WordListCollectionViewDelegateProtocol: UICollectionViewDelegateFlowLayout {
    
}

final class WordListCollectionViewDelegate: NSObject, WordListCollectionViewDelegateProtocol {
    
    fileprivate let dataProvider: WordListDataProviderProcotol
    
    init(dataProvider: WordListDataProviderProcotol) {
        self.dataProvider = dataProvider
    }
    
}
