//
//  EditWordViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import UIKit

final class EditWordViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: EditWordPresenterInputProtocol
    
    fileprivate static let editWordButtonSize: CGSize = .init(width: 40, height: 40)
    fileprivate static let editWordButtonRightOffset: CGFloat = 8
    fileprivate let editWordButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDUIResources.Image.edit.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(presenter: EditWordPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: presenter.getWordText,
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

// MARK: - EditWordPresenterOutputProtocol
extension EditWordViewController: EditWordPresenterOutputProtocol {
    
}

// MARK: - Add Views
fileprivate extension EditWordViewController {
    
    func addViews() {
        addEditWordButton()
    }
    
    func addEditWordButton() {
        editWordButton.addTarget(self, action: #selector(editWordButtonAction), for: .touchUpInside)
        view.addSubview(editWordButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension EditWordViewController {
    
    func addConstraints() {
        addEditWordButtonConstraints()
    }
    
    func addEditWordButtonConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.editWordButton,
                                                     toItem: self.backButton,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.editWordButton,
                                                   toItem: self.navigationBarView,
                                                   constant: -Self.editWordButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.editWordButton,
                                                    constant: Self.editWordButtonSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.editWordButton,
                                                   constant: Self.editWordButtonSize.width)
        
    }
    
    
}

// MARK: - Configure UI
fileprivate extension EditWordViewController {
    
    func configureUI() {
        
    }
    
}

// MARK: - Drop Shadow
fileprivate extension EditWordViewController {
    
    func dropShadow() {
        
    }
    
}

// MARK: - Round Off Edges
fileprivate extension EditWordViewController {
    
    func roundOffEdges() {
        
    }
    
}

// MARK: - Actions
fileprivate extension EditWordViewController {
    
    @objc func editWordButtonAction() {
        presenter.editWordButtonClicked()
    }
    
}
