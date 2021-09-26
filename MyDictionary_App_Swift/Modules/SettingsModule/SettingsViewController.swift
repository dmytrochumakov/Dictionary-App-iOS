//
//  SettingsViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

final class SettingsViewController: MDBaseTitledBackNavigationBarViewController {
    
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
        super.init(title: LocalizedText.settings.localized,
                   navigationBarBackgroundImage: MDUIResources.Image.background_navigation_bar_2.image)
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
    
    func showError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: LocalizedText.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
    func showShareFeedbackActionsSheet() {
        
        UIAlertController.showActionSheet(title: LocalizedText.shareFeedback.localized,
                                          message: nil,
                                          actions: [.init(title: LocalizedText.featureRequest.localized,
                                                          style: .default),
                                                    .init(title: LocalizedText.bugReport.localized,
                                                          style: .default),
                                                    .init(title: LocalizedText.cancel.localized,
                                                          style: .cancel)
                                                   ],
                                          handler: { action in
            
            if (action.title == LocalizedText.featureRequest.localized) {
                self.presenter.shareFeedbackFeatureRequestClicked()
            } else if (action.title == LocalizedText.bugReport.localized) {
                self.presenter.shareFeedbackBugReportClicked()
            } else {
                return
            }
            
        },
                                          presenter: self)
        
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
        self.view.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self.presenter.collectionViewDelegate
        self.collectionView.dataSource = self.presenter.collectionViewDataSource
        self.collectionView.register(SettingsCell.self)
        self.collectionView.backgroundColor = .clear
    }
    
}
