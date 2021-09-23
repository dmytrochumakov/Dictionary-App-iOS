//
//  AppearanceCollectionViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import UIKit

protocol AppearanceCollectionViewDelegateProtocol: UICollectionViewDelegateFlowLayout {
    var didSelectItemAtIndexPath: ((IndexPath) -> Void)? { get set }
}

final class AppearanceCollectionViewDelegate: NSObject,
                                              AppearanceCollectionViewDelegateProtocol {
    
    fileprivate let dataProvider: AppearanceDataProviderProtocol
    
    internal var didSelectItemAtIndexPath: ((IndexPath) -> Void)?
    
    init(dataProvider: AppearanceDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension AppearanceCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAtIndexPath?(indexPath)
    }
    
}

extension AppearanceCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: AppearanceCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}
