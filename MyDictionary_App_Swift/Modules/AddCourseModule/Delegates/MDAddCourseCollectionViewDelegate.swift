//
//  MDAddCourseCollectionViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import UIKit

protocol MDAddCourseCollectionViewDelegateProtocol: UICollectionViewDelegateFlowLayout {
    
}

final class MDAddCourseCollectionViewDelegate: NSObject,
                                               MDAddCourseCollectionViewDelegateProtocol {
    
    fileprivate let dataProvider: AddCourseDataProviderProtocol
    
    init(dataProvider: AddCourseDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDAddCourseCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: MDAddCourseCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (dataProvider.addCourseCellModels(atSection: section)).isEmpty {
            return .zero
        } else {            
            return .init(width: collectionView.bounds.width, height: MDAddCourseHeaderView.height)
        }
    }
    
}
