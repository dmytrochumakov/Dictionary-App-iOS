//
//  AddCourseViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

final class AddCourseViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: AddCoursePresenterInputProtocol
    
    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
    
}

// MARK: - Add Views
fileprivate extension AddCourseViewController {
    
    func addViews() {
        addCollectionView()
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AddCourseViewController {
    
    func addConstraints() {
        addCollectionViewConstraints()
    }
    
    func addCollectionViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.collectionView,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
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
