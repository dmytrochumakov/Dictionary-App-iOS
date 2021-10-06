//
//  MDProgressHUDHelper.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 02.10.2021.
//

import MBProgressHUD

protocol MDProgressHUDHelperProtocol {
    func showProgressHUD(withConfiguration configuration: MDProgressHUDHelper.MDProgressHUDHelperConfiguration)
    func hideProgressHUD(animated: Bool)
    func updateHUDProgress(_ progress: Float)
}

final class MDProgressHUDHelper: MDProgressHUDHelperProtocol {
    
    public struct MDProgressHUDHelperConfiguration {
        
        let view: UIView
        
        /// Default is true
        let animated: Bool
        
        /// Default is  .indeterminate
        let mode: MBProgressHUDMode
        
        /// Default is  nil
        let labelText: String?
        
        /// Default is  nil
        let labelFont: UIFont?
        
        /// Default is  nil
        let labelTextColor: UIColor?
        
        init(view: UIView,
             animated: Bool = true,
             mode: MBProgressHUDMode = .indeterminate,
             labelText: String? = nil,
             labelFont: UIFont? = nil,
             labelTextColor: UIColor? = nil) {
            
            self.view = view
            self.animated = animated
            self.mode = mode
            self.labelText = labelText
            self.labelFont = labelFont
            self.labelTextColor = labelTextColor
            
        }
        
    }
    
    fileprivate var hud: MBProgressHUD!
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

extension MDProgressHUDHelper {
    
    func showProgressHUD(withConfiguration configuration: MDProgressHUDHelperConfiguration) {
        DispatchQueue.main.async {
            //
            if (self.hud == nil) {
                //
                self.hud = self.createHUD(withConfiguration: configuration)
                //
                self.hud.show(animated: configuration.animated)
                //
            } else {
                //
                self.hud.show(animated: configuration.animated)
                //
            }
            //
        }
    }
    
    /// - Parameter animated: true
    func hideProgressHUD(animated: Bool = true) {
        DispatchQueue.main.async {
            //
            if (self.hud == nil) {
                //
                return
                //
            } else {
                //
                self.hud.hide(animated: animated)
                //
                self.hud = nil
                //
            }
            //
        }
    }
    
    func updateHUDProgress(_ progress: Float) {
        DispatchQueue.main.async {
            //
            self.hud.progress = progress
            //
        }
    }
    
}

// MARK: - Create HUD
fileprivate extension MDProgressHUDHelper {
    
    func createHUD(withConfiguration configuration: MDProgressHUDHelperConfiguration) -> MBProgressHUD {
        
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: configuration.view,
                                                         animated: configuration.animated)
        hud.mode = configuration.mode
        hud.label.text = configuration.labelText
        hud.label.font = configuration.labelFont
        hud.label.textColor = configuration.labelTextColor
        
        return hud
        
    }
    
}
