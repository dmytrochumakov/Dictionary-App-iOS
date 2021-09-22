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
                                          MDShowErrorProtocol,
                                          MDShowHideProgressHUD {
    func updateNicknameText(_ text: String)
    func didCompleteLogout()
}

protocol AccountInteractorProtocol: AccountInteractorInputProtocol,
                                    AccountDataManagerOutputProtocol {
    var interactorOutput: AccountInteractorOutputProtocol? { get set }
}

final class AccountInteractor: NSObject,
                               AccountInteractorProtocol {
    
    fileprivate let dataManager: AccountDataManagerInputProtocol
    fileprivate let storageCleanupService: MDStorageCleanupServiceProtocol
    fileprivate let appSettings: MDAppSettingsProtocol
    
    internal weak var interactorOutput: AccountInteractorOutputProtocol?
    
    init(dataManager: AccountDataManagerInputProtocol,
         storageCleanupService: MDStorageCleanupServiceProtocol,
         appSettings: MDAppSettingsProtocol) {
        
        self.dataManager = dataManager
        self.storageCleanupService = storageCleanupService
        self.appSettings = appSettings
        
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
            
            self.interactorOutput?.updateNicknameText(self.dataManager.dataProvider.user!.nickname)
            break
            
        case .failure(let error):
            
            self.interactorOutput?.showError(error)
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
        logOut()
    }
    
}

// MARK: - Private
fileprivate extension AccountInteractor {
    
    func logOut() {
        
        // Show Progress HUD
        interactorOutput?.showProgressHUD()
        //        
        clearAllStorages() { [unowned self] clearAllStoragesResult in
            
            switch clearAllStoragesResult {
                
            case .success:
                
                // Hide Progress HUD
                interactorOutput?.hideProgressHUD()                
                // Set Is Logged False
                appSettings.setIsLoggedFalse()
                //
                interactorOutput?.didCompleteLogout()
                break
                //
                
            case .failure(let error):
                
                // Hide Progress HUD
                interactorOutput?.hideProgressHUD()
                //
                interactorOutput?.showError(error)
                //
                break
                //
            }
            
        }
        
    }
    
    func clearAllStorages(_ completionHandler: @escaping(MDOperationResultWithCompletion<Void>)) {
        
        var resultCount: Int = .zero
        
        storageCleanupService.clearAllStorages { cleanupResults in
            
            cleanupResults.forEach { cleanupResult in
                
                switch cleanupResult.result {
                    
                case .success:
                    
                    resultCount += 1
                    
                    if (resultCount == cleanupResults.count) {
                        completionHandler(.success(()))
                        break
                    }
                    
                case .failure(let error):
                    //
                    completionHandler(.failure(error))
                    //
                    return
                    //
                }
                
            }
            
        }
        
    }
    
}
