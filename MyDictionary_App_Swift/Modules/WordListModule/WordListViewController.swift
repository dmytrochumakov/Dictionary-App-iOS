//
//  WordListViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

final class WordListViewController: MDBaseLargeTitledBackNavigationBarViewController {
    
    fileprivate let presenter: WordListPresenterInputProtocol
    
    fileprivate let searchBar: MDSearchBar = {
        let searchBar: MDSearchBar = .init()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.register(MDWordListCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(presenter: WordListPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: LocalizedText.words.localized,
                   navigationBarBackgroundImage: MDUIResources.Image.background_navigation_bar_1.image)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        addViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    
}

// MARK: - WordListPresenterOutputProtocol
extension WordListViewController: WordListPresenterOutputProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showAlertWithOkAction(title: LocalizedText.error.localized,
                                                    message: error.localizedDescription,
                                                    presenter: self)
        }
    }
    
    func hideKeyboard() {
        DispatchQueue.main.async {
            MDConstants.Keyboard.hideKeyboard(rootView: self.view)
        }
    }
    
}

// MARK: - Add Views
fileprivate extension WordListViewController {
    
    func addViews() {
        addSearchBar()
        addTableView()
    }
    
    func addSearchBar() {
        searchBar.delegate = presenter.searchBarDelegate
        view.addSubview(searchBar)
    }
    
    func addTableView() {
        view.addSubview(tableView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension WordListViewController {
    
    func addConstraints() {
        addSearchBarConstraints()
        addTableViewConstraints()
    }
    
    func addSearchBarConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.searchBar,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: MDConstants.SearchBar.defaultTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.searchBar,
                                                  toItem: self.view,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.searchBar,
                                                   toItem: self.view,
                                                   constant: .zero)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.searchBar,
                                                    constant: MDConstants.SearchBar.defaultHeight)
        
    }
    
    func addTableViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.tableView,
                                              attribute: .top,
                                              toItem: self.searchBar,
                                              attribute: .bottom,
                                              constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.tableView,
                                                  toItem: self.view,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.tableView,
                                                   toItem: self.view,
                                                   constant: .zero)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.tableView,
                                                    toItem: self.view,
                                                    constant: .zero)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension WordListViewController {
    
    func configureUI() {   
        configureTableView()
    }
   
    func configureTableView() {
        self.tableView.delegate = self.presenter.tableViewDelegate
        self.tableView.dataSource = self.presenter.tableViewDataSource
        self.tableView.backgroundColor = .clear
    }
    
}
