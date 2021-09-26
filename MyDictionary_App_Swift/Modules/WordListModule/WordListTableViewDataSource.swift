//
//  WordListTableViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import UIKit

protocol WordListTableViewDataSourceProtocol: UITableViewDataSource {
    
}

final class WordListTableViewDataSource: NSObject,
                                         WordListTableViewDataSourceProtocol {
    
    fileprivate let dataProvider: WordListDataProviderProcotol
    
    init(dataProvider: WordListDataProviderProcotol) {
        self.dataProvider = dataProvider
    }
    
}

extension WordListTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return .init()
    }
    
}
