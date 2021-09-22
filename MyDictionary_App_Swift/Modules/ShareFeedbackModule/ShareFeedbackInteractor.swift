//
//  ShareFeedbackInteractor.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 22.09.2021.

import UIKit

protocol ShareFeedbackInteractorInputProtocol {
    
}

protocol ShareFeedbackInteractorOutputProtocol: AnyObject {
    
}

protocol ShareFeedbackInteractorProtocol: ShareFeedbackInteractorInputProtocol,
                                          ShareFeedbackDataManagerOutputProtocol {
    var interactorOutput: ShareFeedbackInteractorOutputProtocol? { get set }
}

final class ShareFeedbackInteractor: ShareFeedbackInteractorProtocol {
    
    fileprivate let dataManager: ShareFeedbackDataManagerInputProtocol
    internal weak var interactorOutput: ShareFeedbackInteractorOutputProtocol?
    
    init(dataManager: ShareFeedbackDataManagerInputProtocol) {
        self.dataManager = dataManager
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - ShareFeedbackDataManagerOutputProtocol
extension ShareFeedbackInteractor {
    
}
