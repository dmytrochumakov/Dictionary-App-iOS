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
        
        Self.addEqualTopConstraintAndActivate(item: view1,
                                              toItem: view2,
                                              constant: constant)
        
        Self.addEqualLeftConstraintAndActivate(item: view1,
                                               toItem: view2,
                                               constant: constant)
        
        Self.addEqualRightConstraintAndActivate(item: view1,
                                                toItem: view2,
                                                constant: constant)
        
        Self.addEqualBottomConstraintAndActivate(item: view1,
                                                 toItem: view2,
                                                 constant: constant)
        
    }
    
}

extension NSLayoutConstraint {
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualConstraintAndActivate(item view1: Any,
                                              attribute attribute1: NSLayoutConstraint.Attribute,
                                              toItem view2: Any?,
                                              attribute attribute2: NSLayoutConstraint.Attribute,
                                              multiplier: CGFloat = 1,
                                              constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: attribute1,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: attribute2,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualTopConstraintAndActivate(item view1: Any,
                                                 toItem view2: Any?,
                                                 multiplier: CGFloat = 1,
                                                 constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .top,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualLeftConstraintAndActivate(item view1: Any,
                                                  toItem view2: Any?,
                                                  multiplier: CGFloat = 1,
                                                  constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .left,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .left,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualRightConstraintAndActivate(item view1: Any,
                                                   toItem view2: Any?,
                                                   multiplier: CGFloat = 1,
                                                   constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .right,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .right,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualBottomConstraintAndActivate(item view1: Any,
                                                    toItem view2: Any?,
                                                    multiplier: CGFloat = 1,
                                                    constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .bottom,
                                                   multiplier: multiplier,
                                                   constant: constant)
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualCenterXConstraintAndActivate(item view1: Any,
                                                     toItem view2: Any?,
                                                     multiplier: CGFloat = 1,
                                                     constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .centerX,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualCenterYConstraintAndActivate(item view1: Any,
                                                     toItem view2: Any?,
                                                     multiplier: CGFloat = 1,
                                                     constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: view2,
                                                   attribute: .centerY,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualHeightConstraintAndActivate(item view1: Any,
                                                    multiplier: CGFloat = 1,
                                                    constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
    /// - Parameter multiplier: 1
    @discardableResult
    static func addEqualWidthConstraintAndActivate(item view1: Any,
                                                   multiplier: CGFloat = 1,
                                                   constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = .init(item: view1,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: multiplier,
                                                   constant: constant)
        
        constraint.isActive = true
        
        return constraint
        
    }
    
}
