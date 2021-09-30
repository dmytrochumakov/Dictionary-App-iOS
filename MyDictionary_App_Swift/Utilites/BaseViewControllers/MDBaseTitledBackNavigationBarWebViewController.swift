//
//  MDBaseTitledBackNavigationBarWebViewController.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 21.09.2021.
//

import WebKit
import MBProgressHUD

open class MDBaseTitledBackNavigationBarWebViewController: MDBaseTitledBackNavigationBarViewController {
    
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
        
        super.init(title: title,
                   navigationBarBackgroundImage: navigationBarBackgroundImage)
        
        loadWebPage(url)
        
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

// MARK: - WKNavigationDelegate
extension MDBaseTitledBackNavigationBarWebViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        showProgressHUD()        
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideProgressHUD()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideProgressHUD()
    }
    
}

// MARK: - MDShowHideProgressHUD
extension MDBaseTitledBackNavigationBarWebViewController: MDShowHideProgressHUD {
    
    func showProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
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

// MARK: - Load Web Page
fileprivate extension MDBaseTitledBackNavigationBarWebViewController {
    
    func loadWebPage(_ url: URL) {
        webView.load(URLRequest.init(url: url))
        webView.navigationDelegate = self
    }
    
}
