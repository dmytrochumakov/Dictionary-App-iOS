//
//  UITableView+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 19.09.2021.
//

import UIKit

extension UITableView {
    
    final func register<T: UITableViewCell>(_ cellType: T.Type) where T: ReuseIdentifierProtocol {
        self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UITableViewHeaderFooterView>(_ cellType: T.Type) where T: ReuseIdentifierProtocol {
        self.register(cellType.self, forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReuseIdentifierProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Impossible dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    final func dequeueReusableSupplementaryView<T: UITableViewHeaderFooterView>(for indexPath: IndexPath) -> T where T: ReuseIdentifierProtocol {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Impossible dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
}
