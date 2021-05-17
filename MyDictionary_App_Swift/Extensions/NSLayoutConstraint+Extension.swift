//
//  NSLayoutConstraint+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import UIKit

extension NSLayoutConstraint {
    
    static func addItemEqualToItemAndActivate(item view1: Any, toItem view2: Any?) {
        let multiplier: CGFloat = 1
        (view1 as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint.init(item: view1,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: view2,
                                          attribute: .top,
                                          multiplier: multiplier,
                                          constant: .zero)
        
        let left = NSLayoutConstraint.init(item: view1,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: view2,
                                           attribute: .left,
                                           multiplier: multiplier,
                                           constant: .zero)
        
        let right = NSLayoutConstraint.init(item: view1,
                                            attribute: .right,
                                            relatedBy: .equal,
                                            toItem: view2,
                                            attribute: .right,
                                            multiplier: multiplier,
                                            constant: .zero)
        
        let bottom = NSLayoutConstraint.init(item: view1,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: view2,
                                             attribute: .bottom,
                                             multiplier: multiplier,
                                             constant: .zero)
        
        Self.activate([top, left, right, bottom])
    }
    
}
