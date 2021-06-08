//
//  UIViewController+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 06.06.2021.
//

import UIKit

extension UIViewController {
    
    func configureAppearance(fromAppearanceType type: AppearanceType,
                             collectionView: UICollectionView) {
        configureAppearance(fromAppearanceType: type)
        configureCollectionViewBackgroundColor(fromAppearanceType: type,
                                               collectionView: collectionView)
    }
    
    func configureAppearance(fromAppearanceType type: AppearanceType) {
        configureViewBackgroundColor(fromAppearanceType: type)
        configureNavigationBarAppearance(fromAppearanceType: type)
        configureTabBarAppearance(fromAppearanceType: type)
    }
    
    func configureNavigationBarAppearance(fromAppearanceType type: AppearanceType) {
        configureNavigationBarTintColor(fromAppearanceType: type)
        configureNavigationBarTitleTextAttributes(fromAppearanceType: type)
    }
    
    func configureTabBarAppearance(fromAppearanceType type: AppearanceType) {
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
