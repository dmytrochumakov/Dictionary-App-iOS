//
//  CourseListSearchBarDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

protocol MDCourseListSearchBarDelegateProtocol: UISearchBarDelegate {
    var searchBarCancelButtonAction: (() -> Void)? { get set }
}

final class MDCourseListSearchBarDelegate: NSObject,
                                           MDCourseListSearchBarDelegateProtocol {
    
    var searchBarCancelButtonAction: (() -> Void)?
    
}

extension MDCourseListSearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarCancelButtonAction?()
    }
    
}
