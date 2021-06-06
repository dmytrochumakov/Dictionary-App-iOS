//
//  UIViewController+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import UIKit

extension UIViewController {
    
    func configureNavigationBar(fromAppearanceType type: AppearanceType) {
        configureNavigationBarTintColor(fromAppearanceType: type)
        configureNavigationBarTitleTextAttributes(fromAppearanceType: type)
    }
    
    func configureTabBar(fromAppearanceType type: AppearanceType) {
        configureTabBarTintColor(fromAppearanceType: type)
    }
    
    func configureNavigationBarTintColor(fromAppearanceType type: AppearanceType) {
        navigationController?.navigationBar.barTintColor = ConfigurationAppearanceController.navigationBarTintColor(fromAppearanceType: type)
    }
    
    func configureNavigationBarTitleTextAttributes(fromAppearanceType type: AppearanceType) {
        navigationController?.navigationBar.titleTextAttributes = ConfigurationAppearanceController.navigationBarTitleTextAttributes(fromAppearanceType: type)
    }
    
    func configureTabBarTintColor(fromAppearanceType type: AppearanceType) {
        tabBarController?.tabBar.barTintColor = ConfigurationAppearanceController.tabBarTintColor(fromAppearanceType: type)
    }
    
    func configureViewBackgroundColor(fromAppearanceType type: AppearanceType) {
        self.view.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
    }
    
    func configureCollectionViewBackgroundColor(fromAppearanceType type: AppearanceType, collectionView: UICollectionView) {
        collectionView.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor(fromAppearanceType: type)
    }
    
}
