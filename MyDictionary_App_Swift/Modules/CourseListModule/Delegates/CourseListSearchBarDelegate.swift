//
//  CourseListSearchBarDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 18.09.2021.
//

import UIKit

protocol MDCourseListSearchBarDelegateProtocol: MDSearchBarDelegate {
    var searchBarShouldClearAction: (() -> Void)? { get set }
    var searchBarCancelButtonAction: (() -> Void)? { get set }
    var searchBarSearchButtonAction: (() -> Void)? { get set }
    var searchBarTextDidChangeAction: ((String?) -> Void)? { get set }
}

final class MDCourseListSearchBarDelegate: NSObject,
                                           MDCourseListSearchBarDelegateProtocol {
    
    var searchBarShouldClearAction: (() -> Void)?
    var searchBarCancelButtonAction: (() -> Void)?
    var searchBarSearchButtonAction: (() -> Void)?
    var searchBarTextDidChangeAction: ((String?) -> Void)?
    
}

extension MDCourseListSearchBarDelegate {
    
    func searchBarShouldClear(_ searchBar: MDSearchBar) {
        searchBarShouldClearAction?()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: MDSearchBar) {
        searchBarCancelButtonAction?()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: MDSearchBar) {
        searchBarSearchButtonAction?()
    }
    
    func searchBar(_ searchBar: MDSearchBar, textDidChange searchText: String?) {
        searchBarTextDidChangeAction?(searchText)
    }
    
}
