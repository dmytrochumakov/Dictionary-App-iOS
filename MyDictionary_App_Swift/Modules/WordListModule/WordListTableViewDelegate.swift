//
//  WordListTableViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import UIKit

protocol WordListTableViewDelegateProtocol: UITableViewDelegate {
    
}

final class WordListTableViewDelegate: NSObject,
                                       WordListTableViewDelegateProtocol {
    
    fileprivate let dataProvider: WordListDataProviderProcotol
    
    init(dataProvider: WordListDataProviderProcotol) {
        self.dataProvider = dataProvider
    }
    
}

extension WordListTableViewDelegate {
    
}
