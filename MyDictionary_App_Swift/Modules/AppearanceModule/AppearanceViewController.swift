//
//  AppearanceViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 03.06.2021.

import UIKit

final class AppearanceViewController: UIViewController {
    
    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView = UICollectionView.init(frame: .zero,
                                                   collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let presenter: AppearancePresenterInputProtocol
    
    init(presenter: AppearancePresenterInputProtocol) {
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

// MARK: - AppearancePresenterOutputProtocol
extension AppearanceViewController: AppearancePresenterOutputProtocol {
    
    func reloadRows(_ rows: [IndexPath : AppearanceRowModel]) {
        rows.forEach { (indexPath, model) in
            (collectionView.cellForItem(at: indexPath) as! AppearanceCell).fillWithModel(model)
        }
    }
    
}

// MARK: - Add Views
fileprivate extension AppearanceViewController {
    
    func addViews() {
        addCollectionView()
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AppearanceViewController {
    
    func addConstraints() {
        addCollectionConstraints()
    }
    
    func addCollectionConstraints() {
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.collectionView,
                                                         toItem: self.view)
    }
    
}

// MARK: - Configure UI
fileprivate extension AppearanceViewController {
    
    func configureUI() {
        configureView()
        configureCollectionView()
    }
    
    func configureView() {
        self.view.backgroundColor = AppStyling.viewBackgroundColor()
        self.title = KeysForTranslate.appearance.localized
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self.presenter.collectionViewDelegate
        self.collectionView.dataSource = self.presenter.collectionViewDataSource
        self.collectionView.backgroundColor = AppStyling.viewBackgroundColor()
        self.collectionView.register(AppearanceCell.self)
    }
    
}
