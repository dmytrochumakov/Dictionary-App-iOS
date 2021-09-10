//
//  UIView+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.09.2021.
//

import UIKit

extension UIView {
    
    /// - Parameter masksToBounds: false
    /// - Parameter opacity: 0.5
    /// - Parameter radius: 1
    /// - Parameter shouldRasterize: true
    /// - Parameter scale: true
    func dropShadow(masksToBounds: Bool = false,
                    color: UIColor,
                    opacity: Float = 0.5,
                    offSet: CGSize,
                    radius: CGFloat = 1,
                    shouldRasterize: Bool = true,
                    scale: Bool = true) {
        
        layer.masksToBounds = masksToBounds
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = shouldRasterize
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
    
}
