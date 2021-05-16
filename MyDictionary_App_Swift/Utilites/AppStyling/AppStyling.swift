//
//  AppStyling.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct AppStyling {
    
    enum Color {
    
        case systemWhite
        
        /// - Parameter alpha: 1.0 by default
        func color(_ alpha: CGFloat = 1.0) -> UIColor {
            switch self {
            case .systemWhite:
                return UIColor.white.withAlphaComponent(alpha)            
            }
        }
        
    }
    
}
