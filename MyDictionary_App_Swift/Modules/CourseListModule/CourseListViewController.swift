//
//  CourseListViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

final class CourseListViewController: UIViewController {
    
    fileprivate let presenter: CourseListPresenterInputProtocol
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(presenter: CourseListPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    
}

// MARK: - CourseListPresenterOutputProtocol
extension CourseListViewController: CourseListPresenterOutputProtocol {
    
}

// MARK: - Add Views
fileprivate extension CourseListViewController {
    
    func addViews() {
        addTableView()
    }
    
    func addTableView() {
        view.addSubview(tableView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension CourseListViewController {
    
    func addConstraints() {
        addTableViewConstraints()
    }
    
    func addTableViewConstraints() {
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.tableView,
                                                         toItem: self.view)
    }
    
}

// MARK: - Configure UI
fileprivate extension CourseListViewController {
    
    func configureUI() {
        configureView()
        configureTableView()
        configureNavigationBarAppearance(fromAppearanceType: Appearance.current.appearanceType)        
    }
    
    func configureView() {
        self.configureViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
        self.title = KeysForTranslate.courses.localized
    }
    
    func configureTableView() {
        //        self.tableView.delegate = self.presenter.collectionViewDelegate
        //        self.tableView.dataSource = self.presenter.collectionViewDataSource
        self.configureTableViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType,
                                               tableView: tableView)
    }
    
}
