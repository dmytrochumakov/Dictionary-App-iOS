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
    
    func configureAppearance(fromAppearanceType type: AppearanceType,
                             tableView: UITableView) {
        configureAppearance(fromAppearanceType: type)
        configureTableViewBackgroundColor(fromAppearanceType: type,
                                          tableView: tableView)
    }
    
    func configureAppearance(fromAppearanceType type: AppearanceType) {
        configureViewBackgroundColor(fromAppearanceType: type)
        configureNavigationBarAppearance(fromAppearanceType: type)        
    }
    
    // Navigation Bar Appearance //
    func configureNavigationBarAppearance(fromAppearanceType type: AppearanceType) {
        configureNavigationBarTintColor(fromAppearanceType: type)
        configureNavigationBarTitleTextAttributes(fromAppearanceType: type)
    }
        
    func configureNavigationBarTintColor(fromAppearanceType type: AppearanceType) {
        navigationController?.navigationBar.barTintColor = ConfigurationAppearanceController.navigationBarTintColor(fromAppearanceType: type)
    }
    
    func configureNavigationBarTitleTextAttributes(fromAppearanceType type: AppearanceType) {
        navigationController?.navigationBar.titleTextAttributes = ConfigurationAppearanceController.navigationBarTitleTextAttributes(fromAppearanceType: type)
    }
        
    // End Navigation Bar Appearance //
    
    func configureViewBackgroundColor(fromAppearanceType type: AppearanceType) {
        self.view.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
    }
    
    func configureCollectionViewBackgroundColor(fromAppearanceType type: AppearanceType, collectionView: UICollectionView) {
        collectionView.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor(fromAppearanceType: type)
    }
    
    func configureTableViewBackgroundColor(fromAppearanceType type: AppearanceType, tableView: UITableView) {
        tableView.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor(fromAppearanceType: type)
    }
    
}
