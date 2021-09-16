//
//  CourseListViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

final class CourseListViewController: UIViewController {
    
    fileprivate let presenter: CourseListPresenterInputProtocol
    
    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CourseListCell.self)
        return collectionView
    }()
    
    fileprivate let settingsButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDAppStyling.Image.settings.image, for: .normal)
        return button
    }()
    
    fileprivate let addNewCourseButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDAppStyling.Image.add.image, for: .normal)
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
                            collectionView: collectionView)
    }
    
    func showValidationError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: KeysForTranslate.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
}

// MARK: - Add Views
fileprivate extension CourseListViewController {
    
    func addViews() {
        addCollectionView()
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
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
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.collectionView,
                                                         toItem: self.view)
    }
    
}

// MARK: - Configure UI
fileprivate extension CourseListViewController {
    
    func configureUI() {
        configureView()
        configureCollectionView()
        configureNavigationBar()
    }
    
    func configureView() {
        self.configureViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
        self.title = KeysForTranslate.courses.localized
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self.presenter.collectionViewDelegate
        self.collectionView.dataSource = self.presenter.collectionViewDataSource
        self.configureCollectionViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType,
                                                    collectionView: collectionView)
    }
    
    func configureNavigationBar() {
        //
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : MDAppStyling.Color.md_White_0_Light_Appearence.color(),
                                                                        NSAttributedString.Key.font : MDAppStyling.Font.MyriadProSemiBold.font(ofSize: 17)]
        //
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : MDAppStyling.Color.md_White_0_Light_Appearence.color(),
                                                                             NSAttributedString.Key.font : MDAppStyling.Font.MyriadProSemiBold.font(ofSize: 34)]
        //
        self.navigationController?.setNavigationBarBackgroundImage(MDAppStyling.Image.background_navigation_bar_1.image,
                                                                   logoImageViewBackgroundColor: MDAppStyling.Color.md_Blue_1_Light_Appearence.color())
        //
        configureNavigationItemLeftAndRightButtons()
        //
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
