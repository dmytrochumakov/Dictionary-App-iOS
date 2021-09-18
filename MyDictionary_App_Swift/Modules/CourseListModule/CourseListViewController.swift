//
//  CourseListViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

final class CourseListViewController: MDBaseTitledNavigationBarViewController {
    
    fileprivate let presenter: CourseListPresenterInputProtocol
    
    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MDCourseListCell.self)
        return collectionView
    }()
    
    fileprivate let settingsButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDAppStyling.Image.settings.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let addNewCourseButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDAppStyling.Image.add.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate static let searchBarContainerViewHeight: CGFloat = 72
    fileprivate let searchBarContainerView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        dropShadow()
    }
    
}

// MARK: - CourseListPresenterOutputProtocol
extension CourseListViewController: CourseListPresenterOutputProtocol {
    
    func appearanceHasBeenUpdated(_ newValue: AppearanceType) {
        configureAppearance(fromAppearanceType: newValue,
                            collectionView: collectionView)
    }
    
    func showError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: KeysForTranslate.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - Add Views
fileprivate extension CourseListViewController {
    
    func addViews() {
        addCollectionView()
        addSearchBarContainerView()
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
    }
    
    func addSearchBarContainerView() {
        view.addSubview(searchBarContainerView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension CourseListViewController {
    
    func addConstraints() {
        addSearchBarContainerViewConstraints()
        addCollectionViewConstraints()
    }
    
    func addSearchBarContainerViewConstraints() {
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        NSLayoutConstraint.addEqualConstraint(item: self.searchBarContainerView,
                                              attribute: .top,
                                              toItem: navigationBar,
                                              attribute: .bottom,
                                              constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.searchBarContainerView,
                                                  toItem: self.view,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.searchBarContainerView,
                                                   toItem: self.view,
                                                   constant: .zero)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.searchBarContainerView,
                                                    constant: Self.searchBarContainerViewHeight)
        
    }
    
    func addCollectionViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.collectionView,
                                              attribute: .top,
                                              toItem: self.searchBarContainerView,
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
fileprivate extension CourseListViewController {
    
    func configureUI() {
        configureView()
        configureCollectionView()
    }
    
    func configureView() {
        self.configureViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self.presenter.collectionViewDelegate
        self.collectionView.dataSource = self.presenter.collectionViewDataSource
        self.configureCollectionViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType,
                                                    collectionView: collectionView)
    }
    
}

// MARK: - Drop Shadow
fileprivate extension CourseListViewController {
    
    func dropShadow() {
        
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
