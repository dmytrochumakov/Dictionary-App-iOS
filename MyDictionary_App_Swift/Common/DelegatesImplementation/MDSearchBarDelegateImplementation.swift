//
//  MDSearchBarDelegateImplementation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import Foundation

protocol MDSearchBarDelegateImplementationProtocol: MDSearchBarDelegate {
    var searchBarShouldClearAction: (() -> Void)? { get set }
    var searchBarCancelButtonAction: (() -> Void)? { get set }
    var searchBarSearchButtonAction: (() -> Void)? { get set }
    var searchBarTextDidChangeAction: ((String?) -> Void)? { get set }
}

final class MDSearchBarDelegateImplementation: NSObject,
                                               MDSearchBarDelegateImplementationProtocol {
    
    var searchBarShouldClearAction: (() -> Void)?
    var searchBarCancelButtonAction: (() -> Void)?
    var searchBarSearchButtonAction: (() -> Void)?
    var searchBarTextDidChangeAction: ((String?) -> Void)?
    
}

extension MDSearchBarDelegateImplementation {
    
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
