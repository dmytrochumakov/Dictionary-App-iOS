//
//  WordListTableViewDelegate.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 17.05.2021.
//

import UIKit

protocol WordListTableViewDelegateProtocol: UITableViewDelegate {
    var didSelectWord: ((MDWordModel) -> Void)? { get set }
}

final class WordListTableViewDelegate: NSObject,
                                       WordListTableViewDelegateProtocol {
    
    fileprivate let dataProvider: WordListDataProviderProcotol
    
    var didSelectWord: ((MDWordModel) -> Void)?
    
    init(dataProvider: WordListDataProviderProcotol) {
        self.dataProvider = dataProvider
    }
    
}

extension WordListTableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectWord?(dataProvider.wordListCellModel(atIndexPath: indexPath)!.wordResponse)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MDWordListCell.height(tableViewWidth: tableView.bounds.width,
                                     model: dataProvider.wordListCellModel(atIndexPath: indexPath)!)
    }
    
}
