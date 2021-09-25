//
//  AddCourseViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import MBProgressHUD

final class AddCourseViewController: MDBaseLargeTitledBackNavigationBarViewController {
    
    fileprivate let presenter: AddCoursePresenterInputProtocol
    
    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MDAddCourseCell.self)
        collectionView.register(MDAddCourseHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    fileprivate let searchBar: MDSearchBar = {
        let searchBar: MDSearchBar = .init()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    fileprivate static let addButtonLeftOffset: CGFloat = 16
    fileprivate static let addButtonRightOffset: CGFloat = 16
    fileprivate static let addButtonBottomOffset: CGFloat = 24
    fileprivate static let addButtonHeight: CGFloat = 48
    fileprivate let addButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_4400D4.color()
        button.setTitle(LocalizedText.add.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(presenter: AddCoursePresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: LocalizedText.addCourse.localized,
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

// MARK: - AddCoursePresenterOutputProtocol
extension AddCourseViewController: AddCoursePresenterOutputProtocol {
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showAlertWithOkAction(title: LocalizedText.error.localized,
                                                    message: error.localizedDescription,
                                                    presenter: self)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func hideKeyboard() {
        DispatchQueue.main.async {
            MDConstants.Keyboard.hideKeyboard(rootView: self.view)
        }
    }
    
    func selectAndDeselectRow(at results: [Bool : IndexPath]) {
        
        if (results.isEmpty) {
            return
        } else {
            results.forEach { result in
                collectionView.cellForItem(at: result.value)?.isSelected = result.key
            }
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
    
}

// MARK: - Add Views
fileprivate extension AddCourseViewController {
    
    func addViews() {
        addCollectionView()
        addSearchBar()
        addAddButton()
    }
    
    func addSearchBar() {
        searchBar.delegate = presenter.searchBarDelegate
        view.addSubview(searchBar)
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
    }
    
    func addAddButton() {
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AddCourseViewController {
    
    func addConstraints() {
        addSearchBarConstraints()
        addCollectionViewConstraints()
        addAddButtonConstraints()
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
    
    func addCollectionViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.collectionView,
                                              attribute: .top,
                                              toItem: self.searchBar,
                                              attribute: .bottom,
                                              constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.collectionView,
                                                  toItem: self.view,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.collectionView,
                                                   toItem: self.view,
                                                   constant: .zero)
        
        NSLayoutConstraint.addEqualConstraint(item: self.collectionView,
                                              attribute: .bottom,
                                              toItem: self.addButton,
                                              attribute: .top,
                                              constant: .zero)
        
    }
    
    func addAddButtonConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.addButton,
                                                  toItem: self.view,
                                                  constant: Self.addButtonLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.addButton,
                                                   toItem: self.view,
                                                   constant: -Self.addButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.addButton,
                                                    constant: Self.addButtonHeight)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.addButton,
                                                    toItem: self.view,
                                                    constant: -Self.addButtonBottomOffset)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension AddCourseViewController {
    
    func configureUI() {
        configureSelfView()
        configureCollectionView()
    }
    
    func configureSelfView() {
        self.view.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = presenter.collectionViewDelegate
        self.collectionView.dataSource = presenter.collectionViewDataSource
        self.collectionView.backgroundColor = .clear
    }
    
}

// MARK: - Drop Shadow
fileprivate extension AddCourseViewController {
    
    func dropShadow() {
        addButtonDropShadow()
    }
    
    func addButtonDropShadow() {
        addButton.dropShadow(color: MDUIResources.Color.md_4400D4.color(0.5),
                             offSet: .init(width: 0, height: 4),
                             radius: 10)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension AddCourseViewController {
    
    func roundOffEdges() {
        roundOffEdgesAddButton()
    }
    
    func roundOffEdgesAddButton() {
        self.addButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Actions
fileprivate extension AddCourseViewController {
    
    @objc func addButtonAction() {
        presenter.addButtonClicked()
    }
    
}
