//
//  CourseListViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

final class CourseListViewController: MDBaseTitledNavigationBarViewController {
    
    fileprivate let presenter: CourseListPresenterInputProtocol
    
    fileprivate let tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.register(MDCourseListCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    fileprivate static let settingsButtonSize: CGSize = .init(width: 40, height: 40)
    fileprivate static let settingsButtonLeftOffset: CGFloat = 8
    fileprivate static let settingsButtonBottomOffset: CGFloat = 8
    fileprivate let settingsButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDAppStyling.Image.settings.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate static let addNewCourseButtonSize: CGSize = .init(width: 40, height: 40)
    fileprivate static let addNewCourseButtonRightOffset: CGFloat = 8
    fileprivate let addNewCourseButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDAppStyling.Image.add.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate static let searchBarHeight: CGFloat = 56
    fileprivate static let searchBarTopOffset: CGFloat = 16
    fileprivate let searchBar: MDSearchBar = {
        let searchBar: MDSearchBar = .init()        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    init(presenter: CourseListPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: KeysForTranslate.courses.localized,
                   navigationBarBackgroundImage: MDAppStyling.Image.background_navigation_bar_1.image)
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
    
    func showError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: KeysForTranslate.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func hideKeyboard() {
        MDConstants.Keyboard.hideKeyboard(rootView: self.view)
    }
    
}

// MARK: - Add Views
fileprivate extension CourseListViewController {
    
    func addViews() {
        addSettingsButton()
        addAddNewCourseButton()
        addTableView()
        addSearchBar()
    }
    
    func addSettingsButton() {
        settingsButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        view.addSubview(settingsButton)
    }
    
    func addAddNewCourseButton() {
        addNewCourseButton.addTarget(self, action: #selector(addNewCourseButtonAction), for: .touchUpInside)
        view.addSubview(addNewCourseButton)
    }
    
    func addTableView() {
        view.addSubview(tableView)
    }
    
    func addSearchBar() {
        searchBar.delegate = presenter.searchBarDelegate
        view.addSubview(searchBar)
    }
    
}

// MARK: - Add Constraints
fileprivate extension CourseListViewController {
    
    func addConstraints() {
        addSettingsButtonConstraints()
        addAddNewCourseButtonConstraints()
        addTableViewConstraints()
        addSearchBarConstraints()
    }
    
    func addSettingsButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.settingsButton,
                                              attribute: .bottom,
                                              toItem: self.titleLabel,
                                              attribute: .top,
                                              constant: -Self.settingsButtonBottomOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.settingsButton,
                                                  toItem: self.navigationBarView,
                                                  constant: Self.settingsButtonLeftOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.settingsButton,
                                                    constant: Self.settingsButtonSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.settingsButton,
                                                   constant: Self.settingsButtonSize.width)
        
    }
    
    func addAddNewCourseButtonConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.addNewCourseButton,
                                                     toItem: self.settingsButton,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.addNewCourseButton,
                                                   toItem: self.navigationBarView,
                                                   constant: -Self.addNewCourseButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.addNewCourseButton,
                                                    constant: Self.addNewCourseButtonSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.addNewCourseButton,
                                                   constant: Self.addNewCourseButtonSize.width)
        
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
    
    func addSearchBarConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.searchBar,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: Self.searchBarTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.searchBar,
                                                  toItem: self.view,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.searchBar,
                                                   toItem: self.view,
                                                   constant: .zero)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.searchBar,
                                                    constant: Self.searchBarHeight)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension CourseListViewController {
    
    func configureUI() {
        configureView()
        configureTableView()
    }
    
    func configureView() {
        self.configureViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
    }
    
    func configureTableView() {
        self.tableView.delegate = self.presenter.tableViewDelegate
        self.tableView.dataSource = self.presenter.tableViewDataSource
        self.configureTableViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType,
                                               tableView: tableView)
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
