//
//  CourseListCollectionViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListCollectionViewDelegateProtocol: CollectionViewDelegateFlowLayout {
    
}

final class CourseListCollectionViewDelegate: NSObject, CourseListCollectionViewDelegateProtocol {
 
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListCollectionViewDelegate {            
    
}
