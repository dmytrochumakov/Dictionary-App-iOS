//
//  AccountInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol AccountInteractorInputProtocol {
    func viewDidLoad()
    func logOutButtonClicked()
    func deleteAccountButtonClicked()
}

protocol AccountInteractorOutputProtocol: AnyObject,
                                          MDShowErrorProtocol {
    func updateNicknameText(_ text: String)
}

protocol AccountInteractorProtocol: AccountInteractorInputProtocol,
                                    AccountDataManagerOutputProtocol {
    var interactorOutput: AccountInteractorOutputProtocol? { get set }
}

final class AccountInteractor: NSObject,
                               AccountInteractorProtocol {
    
    fileprivate let dataManager: AccountDataManagerInputProtocol
    internal weak var interactorOutput: AccountInteractorOutputProtocol?
    
    init(dataManager: AccountDataManagerInputProtocol) {
        self.dataManager = dataManager
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - AccountDataManagerOutputProtocol
extension AccountInteractor {
    
    func loadAndPassUserToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>) {
        
        switch result {
            
        case .success:
            
            DispatchQueue.main.async {
                self.interactorOutput?.updateNicknameText(self.dataManager.dataProvider.user!.nickname)
            }
            break
            
        case .failure(let error):
            
            DispatchQueue.main.async {
                self.interactorOutput?.showError(error)
            }
            break
            
        }
        
    }
    
}

// MARK: - AccountInteractorInputProtocol
extension AccountInteractor {
    
    func viewDidLoad() {
        dataManager.loadAndPassUserToDataProvider()
    }
    
    func deleteAccountButtonClicked() {
        
    }
    
    func logOutButtonClicked() {
        
    }
    
}
