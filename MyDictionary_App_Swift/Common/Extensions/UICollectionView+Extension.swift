//
//  UICollectionView+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import UIKit

extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(_ cellType: T.Type) where T: MDReuseIdentifierProtocol {
        self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UICollectionReusableView>(_ cellType: T.Type, forSupplementaryViewOfKind: String) where T: MDReuseIdentifierProtocol {
        self.register(cellType.self, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: MDReuseIdentifierProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Impossible dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath) -> T where T: MDReuseIdentifierProtocol {
        guard let cell = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Impossible dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
}
