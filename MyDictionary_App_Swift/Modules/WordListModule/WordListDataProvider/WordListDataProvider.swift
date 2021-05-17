//
//  WordListDataProvider.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListDataProviderProcotol: NumberOfSectionsProtocol,
                                       NumberOfRowsInSectionProtocol {
    
}

final class WordListDataProvider: WordListDataProviderProcotol {
    
}

extension WordListDataProvider {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 0
    }
    
}
