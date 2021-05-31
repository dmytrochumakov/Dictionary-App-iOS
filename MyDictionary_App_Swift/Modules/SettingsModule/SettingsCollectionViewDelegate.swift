//
//  SettingsCollectionViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import UIKit

protocol SettingsCollectionViewDelegateProtocol: CollectionViewDelegateFlowLayout {
    var didSelectItemAtIndexPath: ((IndexPath) -> Void)? { get set }
}

final class SettingsCollectionViewDelegate: NSObject,
                                            SettingsCollectionViewDelegateProtocol {
    
    fileprivate let dataProvider: SettingsDataProviderProtocol
    
    internal var didSelectItemAtIndexPath: ((IndexPath) -> Void)?
    
    init(dataProvider: SettingsDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension SettingsCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAtIndexPath?(indexPath)
    }
    
}

extension SettingsCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: SettingsCell.height)
    }
    
}
