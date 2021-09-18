//
//  CourseListSearchBarDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

protocol MDCourseListSearchBarDelegateProtocol: UISearchBarDelegate {
    var searchBarCancelButtonAction: (() -> Void)? { get set }
    var searchBarSearchButtonAction: (() -> Void)? { get set }
}

final class MDCourseListSearchBarDelegate: NSObject,
                                           MDCourseListSearchBarDelegateProtocol {
    
    var searchBarCancelButtonAction: (() -> Void)?
    var searchBarSearchButtonAction: (() -> Void)?
    
}

extension MDCourseListSearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarCancelButtonAction?()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarSearchButtonAction?()
    }
    
}
