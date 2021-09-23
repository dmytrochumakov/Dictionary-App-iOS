//
//  AddCourseViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

final class AddCourseViewController: MDBaseLargeTitledBackNavigationBarViewController {
    
    fileprivate let presenter: AddCoursePresenterInputProtocol
    
    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MDAddCourseCell.self)
        return collectionView
    }()
    
    fileprivate let searchBar: MDSearchBar = {
        let searchBar: MDSearchBar = .init()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
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
    
}

// MARK: - Add Views
fileprivate extension AddCourseViewController {
    
    func addViews() {
        addCollectionView()
        addSearchBar()
    }
    
    func addSearchBar() {
        searchBar.delegate = presenter.searchBarDelegate
        view.addSubview(searchBar)
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AddCourseViewController {
    
    func addConstraints() {
        addSearchBarConstraints()
        addCollectionViewConstraints()
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
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.collectionView,
                                                    toItem: self.view,
                                                    constant: .zero)
        
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
        
    }
    
    
}

// MARK: - Round Off Edges
fileprivate extension AddCourseViewController {
    
    func roundOffEdges() {
        
    }
    
}

// MARK: - Actions
fileprivate extension AddCourseViewController {
    
    
    
}
