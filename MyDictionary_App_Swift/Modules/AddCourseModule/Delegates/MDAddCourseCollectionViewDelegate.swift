//
//  MDAddCourseCollectionViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import UIKit

protocol MDAddCourseCollectionViewDelegateProtocol: UICollectionViewDelegateFlowLayout {
    var didSelectItem: ((MDAddCourseRow) -> Void)? { get set }
}

final class MDAddCourseCollectionViewDelegate: NSObject,
                                               MDAddCourseCollectionViewDelegateProtocol {
    
    fileprivate let dataProvider: AddCourseDataProviderProtocol
    
    public var didSelectItem: ((MDAddCourseRow) -> Void)?
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(dataProvider.addCourseRow(atIndexPath: indexPath)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}
