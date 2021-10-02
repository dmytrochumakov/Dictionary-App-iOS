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
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()
    
    fileprivate static let addNewWordButtonSize: CGSize = .init(width: 40, height: 40)
    fileprivate static let addNewWordButtonRightOffset: CGFloat = 8
    fileprivate let addNewWordButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDUIResources.Image.add.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let hud: MDProgressHUDHelperProtocol = {
        return MDProgressHUDHelper.init()
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
            UIAlertController.showAlertWithOkAction(title: MDLocalizedText.error.localized,
                                                    message: error.localizedDescription,
                                                    presenter: self)
        }
    }
    
    func hideKeyboard() {
        DispatchQueue.main.async {
            MDConstants.Keyboard.hideKeyboard(rootView: self.view)
        }
    }
    
    func deleteRow(atIndexPath indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func insertRow(atIndexPath indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
    }
    
    func showProgressHUD() {
        DispatchQueue.main.async {
            self.hud.showProgressHUD(withConfiguration: .init(view: self.view))
        }
    }
    
    func hideProgressHUD() {
        DispatchQueue.main.async {
            self.hud.hideProgressHUD(animated: true)
        }
    }
    
    func updateRow(atIndexPath indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
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
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.tableView,
                                                    toItem: self.view,
                                                    constant: .zero)
        
    }
    
    func addAddNewWordButtonConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.addNewWordButton,
                                                     toItem: self.backButton,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.addNewWordButton,
                                                   toItem: self.navigationBarView,
                                                   constant: -Self.addNewWordButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.addNewWordButton,
                                                    constant: Self.addNewWordButtonSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.addNewWordButton,
                                                   constant: Self.addNewWordButtonSize.width)
        
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

// MARK: - Actions
fileprivate extension WordListViewController {
    
    @objc func addNewWordButtonAction() {
        presenter.addNewWordButtonClicked()
    }
    
}
