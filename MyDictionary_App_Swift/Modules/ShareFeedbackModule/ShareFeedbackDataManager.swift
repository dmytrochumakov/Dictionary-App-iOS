//
//  ShareFeedbackDataManager.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 22.09.2021.

import Foundation

protocol ShareFeedbackDataManagerInputProtocol {
    
}

protocol ShareFeedbackDataManagerOutputProtocol: AnyObject {
    
}

protocol ShareFeedbackDataManagerProtocol: ShareFeedbackDataManagerInputProtocol {
    var dataProvider: ShareFeedbackDataProviderProtocol { get }
    var dataManagerOutput: ShareFeedbackDataManagerOutputProtocol? { get set }
}

final class ShareFeedbackDataManager: ShareFeedbackDataManagerProtocol {
    
    internal let dataProvider: ShareFeedbackDataProviderProtocol
    internal weak var dataManagerOutput: ShareFeedbackDataManagerOutputProtocol?
    
    init(dataProvider: ShareFeedbackDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
