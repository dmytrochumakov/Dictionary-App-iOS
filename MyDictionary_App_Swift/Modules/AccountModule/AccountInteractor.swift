//
//  AccountInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

protocol AccountInteractorInputProtocol: MDViewDidLoadProtocol {    
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
    fileprivate let apiAccount: MDAPIAccountProtocol
    fileprivate let jwtMemoryStorage: MDJWTMemoryStorageProtocol
    fileprivate let operationQueueManager: MDOperationQueueManagerProtocol
    
    internal weak var interactorOutput: AccountInteractorOutputProtocol?
    
    init(dataManager: AccountDataManagerInputProtocol,
         storageCleanupService: MDStorageCleanupServiceProtocol,
         appSettings: MDAppSettingsProtocol,
         apiAccount: MDAPIAccountProtocol,
         jwtMemoryStorage: MDJWTMemoryStorageProtocol,
         operationQueueManager: MDOperationQueueManagerProtocol) {
        
        self.dataManager = dataManager
        self.storageCleanupService = storageCleanupService
        self.appSettings = appSettings
        self.apiAccount = apiAccount
        self.jwtMemoryStorage = jwtMemoryStorage
        self.operationQueueManager = operationQueueManager
        
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
        deleteAccount()
    }
    
    func logOutButtonClicked() {
        logOut()
    }
    
}

// MARK: - Private
fileprivate extension AccountInteractor {
    
    func deleteAccount() {
        
        // Show Progress HUD
        interactorOutput?.showProgressHUD()
        //
        jwtMemoryStorage.readFirstJWT { [unowned self] readJWTResult in
            
            switch readJWTResult {
                
            case .success(let jwtResponse):
                
                apiAccount.deleteAccount(accessToken: jwtResponse.accessToken,
                                         userId: dataManager.dataProvider.user!.userId) { [unowned self] (deleteAccountResult) in
                    
                    switch deleteAccountResult {
                        
                    case .success:
                        //
                        logOut()
                        //
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
                // Cancel All Operations
                operationQueueManager.cancelAllOperations()
                //
                interactorOutput?.didCompleteLogout()
                //
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
        
        let operationQueue: OperationQueue = .init()
        operationQueue.name = String("MD\(#function)\(Self.self)")
        
        var resultCount: Int = .zero
        
        let clearAllStoragesOperation = storageCleanupService.clearAllStorages { cleanupResults in
            
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
        
        operationQueue.addOperation(clearAllStoragesOperation)
        
    }
    
}
