//
//  WordListViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

final class WordListViewController: MDBaseLargeTitledBackNavigationBarViewController {
    
    fileprivate let presenter: WordListPresenterInputProtocol
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        
    }
    
}

// MARK: - Add Views
fileprivate extension WordListViewController {
    
    func addViews() {
        addTableView()
    }
    
    func addTableView() {
        view.addSubview(tableView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension WordListViewController {
    
    func addConstraints() {
        addTableViewConstraints()
    }
    
    func addTableViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.tableView,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
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
        configureView()
        configureTableView()
    }
    
    func configureView() {
        self.view.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
        self.title = LocalizedText.words.localized
    }
    
    func configureTableView() {
        self.tableView.delegate = self.presenter.tableViewDelegate
        self.tableView.dataSource = self.presenter.tableViewDataSource
        self.tableView.backgroundColor = .clear
    }
    
}
