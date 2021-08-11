//
//  CourseListViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 11.08.2021.

import UIKit

final class CourseListViewController: UIViewController {

    fileprivate let presenter: CourseListPresenterInputProtocol

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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}

// MARK: - CourseListPresenterOutputProtocol
extension CourseListViewController: CourseListPresenterOutputProtocol {
       
}

// MARK: - Configure UI
fileprivate extension CourseListViewController {
    
    func configureUI() {
        configureView()
        configureTableView()
        configureNavigationBarAppearance(fromAppearanceType: Appearance.current.appearanceType)
        configureTabBarAppearance(fromAppearanceType: Appearance.current.appearanceType)
    }
    
    func configureView() {
        self.configureViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType)
        self.title = KeysForTranslate.courses.localized
    }
    
    func configureTableView() {
//        self.tableView.delegate = self.presenter.collectionViewDelegate
//        self.tableView.dataSource = self.presenter.collectionViewDataSource
//        self.configureTableViewBackgroundColor(fromAppearanceType: Appearance.current.appearanceType,
//                                                    collectionView: collectionView)
    }
    
}
