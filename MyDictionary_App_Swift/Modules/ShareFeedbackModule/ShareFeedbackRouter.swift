//
//  ShareFeedbackRouter.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 22.09.2021.

import UIKit

protocol ShareFeedbackRouterProtocol {
    var presenter: UIViewController? { get set }
}

final class ShareFeedbackRouter: ShareFeedbackRouterProtocol {
    
    internal weak var presenter: UIViewController?
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}
