//
//  NSLayoutConstraint+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import UIKit

extension NSLayoutConstraint {
    
    static func addItemEqualToItemAndActivate(item view1: Any, toItem view2: Any?) {
        let constant: CGFloat = .zero
        
        Self.addEqualTopConstraint(item: view1,
                                   toItem: view2,
                                   constant: constant)
        
        Self.addEqualLeftConstraint(item: view1,
                                    toItem: view2,
                                    constant: constant)
        
        Self.addEqualRightConstraint(item: view1,
                                     toItem: view2,
                                     constant: constant)
        
        Self.addEqualBottomConstraint(item: view1,
                                      toItem: view2,
                                      constant: constant)
        
    }
    
}

extension NSLayoutConstraint {
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualConstraint(item view1: Any,
                                   attribute attribute1: NSLayoutConstraint.Attribute,
                                   toItem view2: Any?,
                                   attribute attribute2: NSLayoutConstraint.Attribute,
                                   multiplier: CGFloat = 1,
                                   constant: CGFloat,
                                   isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: attribute1,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: attribute2,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualTopConstraint(item view1: Any,
                                      toItem view2: Any?,
                                      multiplier: CGFloat = 1,
                                      constant: CGFloat,
                                      isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .top,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualLeftConstraint(item view1: Any,
                                       toItem view2: Any?,
                                       multiplier: CGFloat = 1,
                                       constant: CGFloat,
                                       isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .left,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .left,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualRightConstraint(item view1: Any,
                                        toItem view2: Any?,
                                        multiplier: CGFloat = 1,
                                        constant: CGFloat,
                                        isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .right,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .right,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualBottomConstraint(item view1: Any,
                                         toItem view2: Any?,
                                         multiplier: CGFloat = 1,
                                         constant: CGFloat,
                                         isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .bottom,
                                                   multiplier: multiplier,
                                                   constant: constant)
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualCenterXConstraint(item view1: Any,
                                          toItem view2: Any?,
                                          multiplier: CGFloat = 1,
                                          constant: CGFloat,
                                          isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .centerX,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualCenterYConstraint(item view1: Any,
                                          toItem view2: Any?,
                                          multiplier: CGFloat = 1,
                                          constant: CGFloat,
                                          isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .centerY,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualHeightConstraint(item view1: Any,
                                         multiplier: CGFloat = 1,
                                         constant: CGFloat,
                                         isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    /// - Parameter isActive: true
    @discardableResult
    static func addEqualWidthConstraint(item view1: Any,
                                        multiplier: CGFloat = 1,
                                        constant: CGFloat,
                                        isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = isActive
        
        return constraint
        
    }
    
}
