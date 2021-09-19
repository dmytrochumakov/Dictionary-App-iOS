//
//  CourseListTableViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 11.08.2021.
//

import UIKit

protocol CourseListTableViewDelegateProtocol: CollectionViewDelegateFlowLayout {
    
}

final class CourseListTableViewDelegate: NSObject, CourseListTableViewDelegateProtocol {
 
    fileprivate let dataProvider: CourseListDataProviderProtocol
    
    init(dataProvider: CourseListDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension CourseListTableViewDelegate {            
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: MDCourseListCell.height)
    }
    
}
