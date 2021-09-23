//
//  AddCourseViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

final class AddCourseViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: AddCoursePresenterInputProtocol
    
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
        
    }
    
    
    
}

// MARK: - Add Constraints
fileprivate extension AddCourseViewController {
    
    func addConstraints() {
        
    }
    
    
}

// MARK: - Configure UI
fileprivate extension AddCourseViewController {
    
    func configureUI() {
        
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
