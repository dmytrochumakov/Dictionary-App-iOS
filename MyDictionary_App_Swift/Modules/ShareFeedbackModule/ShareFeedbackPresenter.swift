//
//  ShareFeedbackPresenter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 22.09.2021.

import UIKit

protocol ShareFeedbackPresenterInputProtocol {
    
}

protocol ShareFeedbackPresenterOutputProtocol: AnyObject {
    
}

protocol ShareFeedbackPresenterProtocol: ShareFeedbackPresenterInputProtocol,
                                         ShareFeedbackInteractorOutputProtocol {
    var presenterOutput: ShareFeedbackPresenterOutputProtocol? { get set }
}

final class ShareFeedbackPresenter: NSObject, ShareFeedbackPresenterProtocol {
    
    fileprivate let interactor: ShareFeedbackInteractorInputProtocol
    fileprivate let router: ShareFeedbackRouterProtocol
    
    internal weak var presenterOutput: ShareFeedbackPresenterOutputProtocol?
    
    init(interactor: ShareFeedbackInteractorInputProtocol,
         router: ShareFeedbackRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - ShareFeedbackInteractorOutputProtocol
extension ShareFeedbackPresenter {
    
}
