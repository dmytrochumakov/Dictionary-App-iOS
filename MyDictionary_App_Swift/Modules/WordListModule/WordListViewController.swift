//
//  WordListViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import UIKit

final class WordListViewController: UIViewController {
    
    fileprivate let presenter: WordListPresenterInputProtocol
    
    init(presenter: WordListPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
}

// MARK: - WordListPresenterOutputProtocol
extension WordListViewController: WordListPresenterOutputProtocol {
    
    func reloadData() {
        
    }
    
}

// MARK: - Configure UI
fileprivate extension WordListViewController {

    func configureUI() {
        configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = AppStyling.Color.systemWhite.color()
    }
    
}
