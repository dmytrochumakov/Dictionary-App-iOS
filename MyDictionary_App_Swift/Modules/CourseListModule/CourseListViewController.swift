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
            
    fileprivate let settingsButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle(KeysForTranslate.settings.localized, for: .normal)
        button.setTitleColor(ConfigurationAppearanceController.buttonTextColor(), for: .normal)
        button.titleLabel?.font = AppStyling.Font.systemFont.font(ofSize: 17)
        return button
    }()
    
    fileprivate let addNewCourseButton: UIButton = {
        let button: UIButton = .init()
        button.setTitle(KeysForTranslate.add.localized, for: .normal)
        button.setTitleColor(ConfigurationAppearanceController.buttonTextColor(), for: .normal)
        button.titleLabel?.font = AppStyling.Font.systemFont.font(ofSize: 17)
        return button
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
    
    func appearanceHasBeenUpdated(_ newValue: AppearanceType) {
        configureAppearance(fromAppearanceType: newValue,
                            tableView: tableView)
    }
    
}

// MARK: - Add Views
fileprivate extension CourseListViewController {
    
    func addViews() {
        addTableView()
    }
    
    func addTableView() {
        view.addSubview(tableView)
    }
    
    func addLeftNavigationButton() {
        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = .init(customView: self.settingsButton)
    }
    
    func addRightNavigationButton() {
        addNewCourseButton.addTarget(self, action: #selector(addNewCourseButtonAction), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = .init(customView: self.addNewCourseButton)
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
        configureNavigationItemLeftAndRightButtons()
    }
    
    func configureView() {
        self.configureViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
        self.title = KeysForTranslate.courses.localized
    }
    
    func configureTableView() {
        self.tableView.delegate = self.presenter.tableViewDelegate
        self.tableView.dataSource = self.presenter.tableViewDataSource
        self.configureTableViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType,
                                               tableView: tableView)
    }
    
    func configureNavigationItemLeftAndRightButtons() {
        addLeftNavigationButton()
        addRightNavigationButton()
    }
    
}

// MARK: - Actions
fileprivate extension CourseListViewController {
    
    @objc func addNewCourseButtonAction() {
        presenter.addNewCourseButtonClicked()
    }
    
    @objc func settingsButtonAction() {
        presenter.settingsButtonClicked()
    }
    
}
