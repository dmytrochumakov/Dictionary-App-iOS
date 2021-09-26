//
//  WordListTableViewDataSource.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import MGSwipeTableCell

protocol WordListTableViewDataSourceProtocol: UITableViewDataSource {
    var deleteButtonAction: ((IndexPath) -> Void)? { get set }
}

final class WordListTableViewDataSource: NSObject,
                                         WordListTableViewDataSourceProtocol {
    
    fileprivate let dataProvider: WordListDataProviderProcotol
    
    var deleteButtonAction: ((IndexPath) -> Void)?
    
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
        let cell: MDWordListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillWithModel(dataProvider.wordListCellModel(atIndexPath: indexPath))
        let deleteButton: MGSwipeButton = .init(title: MDConstants.StaticText.emptyString,
                                                icon: MDUIResources.Image.delete.image,
                                                backgroundColor: MDUIResources.Color.md_FFFFFF.color()) { [weak self] (sender) -> Bool in
            
            
            self?.deleteButtonAction?(tableView.indexPath(for: sender)!)
            
            return true
            
        }
        cell.rightButtons = [deleteButton]
        return cell
    }
    
}
