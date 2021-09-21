//
//  SettingsViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

final class SettingsViewController: MDBaseLargeTitledBackNavigationBarViewController {
    
    fileprivate let presenter: SettingsPresenterInputProtocol
    
    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView = UICollectionView.init(frame: .zero,
                                                   collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(presenter: SettingsPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: KeysForTranslate.settings.localized,
                   navigationBarBackgroundImage: MDAppStyling.Image.background_navigation_bar_2.image)
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

// MARK: - SettingsPresenterOutputProtocol
extension SettingsViewController: SettingsPresenterOutputProtocol {
    
    func appearanceHasBeenUpdated(_ newValue: AppearanceType) {
        configureAppearance(fromAppearanceType: newValue,
                            collectionView: collectionView)
    }
    
}

// MARK: - Add Views
fileprivate extension SettingsViewController {
    
    func addViews() {
        addCollectionView()
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension SettingsViewController {
    
    func addConstraints() {
        addCollectionConstraints()
    }
    
    func addCollectionConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.collectionView,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: 24)
        
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
fileprivate extension SettingsViewController {
    
    func configureUI() {
        configureView()
        configureCollectionView()
    }
    
    func configureView() {
        self.view.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor()
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self.presenter.collectionViewDelegate
        self.collectionView.dataSource = self.presenter.collectionViewDataSource
        self.collectionView.register(SettingsCell.self)
        self.collectionView.backgroundColor = .clear
    }
    
}
