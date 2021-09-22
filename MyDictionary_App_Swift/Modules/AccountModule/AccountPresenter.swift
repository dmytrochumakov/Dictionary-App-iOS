//
//  AccountPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol AccountPresenterInputProtocol {
    func viewDidLoad()
}

protocol AccountPresenterOutputProtocol: AnyObject,
                                         MDShowErrorProtocol {
    func updateNicknameText(_ text: String)
}

protocol AccountPresenterProtocol: AccountPresenterInputProtocol,
                                   AccountInteractorOutputProtocol {
    var presenterOutput: AccountPresenterOutputProtocol? { get set }
}

final class AccountPresenter: NSObject,
                              AccountPresenterProtocol {
    
    fileprivate let interactor: AccountInteractorInputProtocol
    fileprivate let router: AccountRouterProtocol
    
    internal weak var presenterOutput: AccountPresenterOutputProtocol?
    
    init(interactor: AccountInteractorInputProtocol,
         router: AccountRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AccountInteractorOutputProtocol
extension AccountPresenter {
    
    func updateNicknameText(_ text: String) {
        self.presenterOutput?.updateNicknameText(text)
    }
    
    func showError(_ error: Error) {
        self.presenterOutput?.showError(error)
    }
    
}

// MARK: - AccountPresenterInputProtocol
extension AccountPresenter {
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
}
