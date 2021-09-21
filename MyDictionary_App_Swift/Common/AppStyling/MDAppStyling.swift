//
//  MDAppStyling.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

struct MDAppStyling {
    
    enum Color {
        
        case md_FFFFFF
        case md_3C3C3C
        case md_4400D4
        case md_5200FF
        case md_C7C7CC
        
        
        /// - Parameter alpha: 1.0 by default
        func color(_ alpha: CGFloat = 1.0) -> UIColor {
            switch self {
                
            case .md_FFFFFF:
                return .init(rgb: 0xFFFFFF, alpha: alpha)
                
            case .md_3C3C3C:
                return .init(rgb: 0x3C3C3C, alpha: alpha)
                
            case .md_4400D4:
                return .init(rgb: 0x4400D4, alpha: alpha)
                
            case .md_5200FF:
                return .init(rgb: 0x5200FF, alpha: alpha)
                
            case.md_C7C7CC:
                return .init(rgb: 0xC7C7CC, alpha: alpha)
                
            }
        }
        
    }
    
    enum Font {
        
        // MyriadPro
        case MyriadProBold
        case MyriadProSemiBold
        case MyriadProItalic
        case MyriadProRegular
        //
        
        /// - Parameter ofSize: MDConstants.Font.defaultSize by default
        func font(ofSize size: CGFloat = MDConstants.Font.defaultSize) -> UIFont {
            switch self {
            case .MyriadProBold:
                return .init(name: "MyriadPro-Bold", size: size)!
            case .MyriadProSemiBold:
                return .init(name: "MyriadPro-Semibold", size: size)!
            case .MyriadProItalic:
                return .init(name: "MyriadPro-It", size: size)!
            case .MyriadProRegular:
                return .init(name: "MyriadPro-Regular", size: size)!
            }
        }
        
    }
    
    enum Image: String {
        
        case background_navigation_bar_0
        case background_typography_0
        case my_dictionary
        case background_typography_1
        case back_white_arrow
        case eye_closed
        case eye_open
        case background_typography_2
        case add
        case settings
        case background_navigation_bar_1
        case right_arrow
        case search
        case delete
        case background_navigation_bar_2
        
        var image: UIImage {
            
            switch self {
                
            case .background_navigation_bar_0,
                    .background_typography_0,
                    .my_dictionary,
                    .background_typography_1,
                    .eye_open,
                    .eye_closed,
                    .back_white_arrow,
                    .background_typography_2,
                    .add,
                    .settings,
                    .background_navigation_bar_1,
                    .right_arrow,
                    .search,
                    .delete,
                    .background_navigation_bar_2:
                
                return configuredImage(fromName: self.rawValue)
                
            }
            
        }
        
        private func configuredImage(fromName name: String) -> UIImage {
            return imageWithAlwaysOriginalMode(image(fromName: name))
        }
        
        private func image(fromName name: String) -> UIImage {
            guard let image: UIImage = .init(named: name) else { fatalError("\(Self.self), \(#function), Cannot find image with name: \(name)") }
            return image
        }
        
        private func imageWithAlwaysOriginalMode(_ image: UIImage) -> UIImage {
            return image.withRenderingMode(.alwaysOriginal)
        }
        
    }
    
}
