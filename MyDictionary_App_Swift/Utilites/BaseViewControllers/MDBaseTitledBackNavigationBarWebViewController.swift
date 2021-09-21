//
//  MDBaseTitledBackNavigationBarWebViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.09.2021.
//

import WebKit

open class MDBaseTitledBackNavigationBarWebViewController: MDBaseTitledBackNavigationBarViewController,
                                                           WKNavigationDelegate {
    
    fileprivate let webView: WKWebView = {
        let webView: WKWebView = .init()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .clear
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    init(url: URL,
         title: String,
         navigationBarBackgroundImage: UIImage) {
        
        webView.load(URLRequest.init(url: url))
        
        super.init(title: title,
                   navigationBarBackgroundImage: navigationBarBackgroundImage)
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        super.loadView()
        addViews()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    
}

// MARK: - Add Views
fileprivate extension MDBaseTitledBackNavigationBarWebViewController {
    
    func addViews() {
        addWebView()
    }
    
    func addWebView() {
        view.addSubview(webView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDBaseTitledBackNavigationBarWebViewController {
    
    func addConstraints() {
        addWebViewConstraints()
    }
    
    func addWebViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.webView,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.webView,
                                                  toItem: self.view,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.webView,
                                                   toItem: self.view,
                                                   constant: .zero)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.webView,
                                                    toItem: self.view,
                                                    constant: .zero)
        
    }
    
}
