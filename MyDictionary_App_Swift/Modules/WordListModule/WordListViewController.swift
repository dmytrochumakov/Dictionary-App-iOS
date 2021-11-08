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
        tableView.separatorStyle = .singleLine
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()
    
    fileprivate static let addNewWordButtonHeight: CGFloat = 48
    fileprivate static let addNewWordButtonLeftOffset: CGFloat = 16
    fileprivate static let addNewWordButtonRightOffset: CGFloat = 16
    fileprivate static let addNewWordButtonBottomOffset: CGFloat = 24
    fileprivate let addNewWordButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_4400D4.color()
        button.setTitle(MDLocalizedText.add.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(presenter: WordListPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: MDLocalizedText.words.localized,
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
        roundOffEdges()
        dropShadow()
    }
    
}

// MARK: - WordListPresenterOutputProtocol
extension WordListViewController: WordListPresenterOutputProtocol {
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: MDLocalizedText.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
    func hideKeyboard() {
        MDConstants.Keyboard.hideKeyboard(rootView: self.view)
    }
    
    func deleteRow(atIndexPath indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func insertRow(atIndexPath indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .fade)
        self.tableView.endUpdates()
    }
    
    func showProgressHUD() {
        MDConstants.MDNetworkActivityIndicator.show()
    }
    
    func hideProgressHUD() {
        MDConstants.MDNetworkActivityIndicator.hide()
    }
    
    func updateRow(atIndexPath indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}

// MARK: - Add Views
fileprivate extension WordListViewController {
    
    func addViews() {
        addSearchBar()
        addTableView()
        addAddNewWordButton()
    }
    
    func addSearchBar() {
        searchBar.delegate = presenter.searchBarDelegate
        view.addSubview(searchBar)
    }
    
    func addTableView() {
        view.addSubview(tableView)
    }
    
    func addAddNewWordButton() {
        addNewWordButton.addTarget(self, action: #selector(addNewWordButtonAction), for: .touchUpInside)
        view.addSubview(addNewWordButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension WordListViewController {
    
    func addConstraints() {
        addSearchBarConstraints()
        addTableViewConstraints()
        addAddNewWordButtonConstraints()
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
        
        NSLayoutConstraint.addEqualConstraint(item: self.tableView,
                                              attribute: .bottom,
                                              toItem: self.addNewWordButton,
                                              attribute: .top,
                                              constant: .zero)
        
    }
    
    func addAddNewWordButtonConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.addNewWordButton,
                                                  toItem: self.view,
                                                  constant: Self.addNewWordButtonLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.addNewWordButton,
                                                   toItem: self.view,
                                                   constant: -Self.addNewWordButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.addNewWordButton,
                                                    constant: Self.addNewWordButtonHeight)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.addNewWordButton,
                                                    toItem: self.view,
                                                    constant: -Self.addNewWordButtonBottomOffset)
        
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

// MARK: - Drop Shadow
fileprivate extension WordListViewController {
    
    func dropShadow() {
        addNewWordButtonDropShadow()
    }
    
    func addNewWordButtonDropShadow() {
        addNewWordButton.dropShadow(color: MDUIResources.Color.md_4400D4.color(0.5),
                                    offSet: .init(width: 0, height: 4),
                                    radius: 10)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension WordListViewController {
    
    func roundOffEdges() {
        roundOffEdgesAddNewWordButton()
    }
    
    func roundOffEdgesAddNewWordButton() {
        self.addNewWordButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Actions
fileprivate extension WordListViewController {
    
    @objc func addNewWordButtonAction() {
        presenter.addNewWordButtonClicked()
    }
    
}
