//
//  SelectCourseViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 23.09.2021.

import UIKit

final class SelectCourseViewController: UIViewController {

    fileprivate let presenter: SelectCoursePresenterInputProtocol

    init(presenter: SelectCoursePresenterInputProtocol) {
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
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}

// MARK: - SelectCoursePresenterOutputProtocol
extension SelectCourseViewController: SelectCoursePresenterOutputProtocol {
       
}
