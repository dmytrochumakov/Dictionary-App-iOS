//
//  CourseListViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import MBProgressHUD

final class CourseListViewController: MDBaseLargeTitledNavigationBarViewController {
    
    fileprivate let presenter: CourseListPresenterInputProtocol
    
    fileprivate let tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.register(MDCourseListCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()
    
    fileprivate static let settingsButtonSize: CGSize = .init(width: 40, height: 40)
    fileprivate static let settingsButtonLeftOffset: CGFloat = 8
    fileprivate static let settingsButtonBottomOffset: CGFloat = 8
    fileprivate let settingsButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDUIResources.Image.settings.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate static let addNewCourseButtonSize: CGSize = .init(width: 40, height: 40)
    fileprivate static let addNewCourseButtonRightOffset: CGFloat = 8
    fileprivate let addNewCourseButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDUIResources.Image.add.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let searchBar: MDSearchBar = {
        let searchBar: MDSearchBar = .init()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    init(presenter: CourseListPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: MDLocalizedText.courses.localized,
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

// MARK: - CourseListPresenterOutputProtocol
extension CourseListViewController: CourseListPresenterOutputProtocol {
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showAlertWithOkAction(title: MDLocalizedText.error.localized,
                                                    message: error.localizedDescription,
                                                    presenter: self)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func hideKeyboard() {
        DispatchQueue.main.async {
            MDConstants.Keyboard.hideKeyboard(rootView: self.view)
        }
    }
    
    func deleteCourseButtonClicked(_ cell: MDCourseListCell) {
        presenter.deleteCourse(atIndexPath: tableView.indexPath(for: cell)!)
    }
    
    func deleteRow(atIndexPath indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func showProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func insertRow(atIndexPath indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
        }
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
    
}

// MARK: - Configure UI
fileprivate extension CourseListViewController {
    
    func configureUI() {
        configureSelfView()
        configureTableView()
    }
    
    func configureSelfView() {
        self.view.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
    }
    
    func configureTableView() {
        self.tableView.delegate = self.presenter.tableViewDelegate
        self.tableView.dataSource = self.presenter.tableViewDataSource
        self.tableView.backgroundColor = .clear
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
