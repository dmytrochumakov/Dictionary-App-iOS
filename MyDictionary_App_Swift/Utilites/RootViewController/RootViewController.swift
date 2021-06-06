//
//  RootViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 04.06.2021.
//

import UIKit

struct RootViewController {
    
    static var viewController: UIViewController {
        let wordListModule = WordListModule.init().module
        let settingsModule = SettingsModule.init().module
        return MainTabBarModule.init(sender: .init(wordListVC: wordListModule,
                                                   settingsVC: settingsModule)).module
    }
    
}
