//
//  MDSearchBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 19.09.2021.
//

import UIKit

protocol MDSearchBarDelegate: AnyObject {
    func searchBarCancelButtonClicked(_ searchBar: MDSearchBar)
    func searchBarSearchButtonClicked(_ searchBar: MDSearchBar)
    func searchBar(_ searchBar: MDSearchBar, textDidChange searchText: String?)
}

final class MDSearchBar: UIView {

    fileprivate static let searchTextFieldContrainerViewHeight: CGFloat = 56
    fileprivate let searchTextFieldContrainerView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate static let searchTextFieldHeight: CGFloat = 40
    fileprivate static let searchTextFieldLeftOffset: CGFloat = 16
    fileprivate static let searchTextFieldRightOffset: CGFloat = 16
    fileprivate let searchTextField: UITextField = {
        let textField: UITextField = .init()
        textField.placeholder = KeysForTranslate.search.localized
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        textField.textColor = MDAppStyling.Color.md_Black_3C3C3C_Light_Appearence.color()
        textField.returnKeyType = .search
        textField.backgroundColor = MDAppStyling.Color.md_White_FFFFFF_Light_Appearence.color()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public weak var delegate: MDSearchBarDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
        dropShadow()
    }
    
}

// MARK: - Add Views
fileprivate extension MDSearchBar {
    
    func addViews() {
        addSearchTextFieldContrainerView()
        addSearchTextField()
    }
    
    func addSearchTextFieldContrainerView() {
        addSubview(searchTextFieldContrainerView)
    }
    
    func addSearchTextField() {
        searchTextField.addTarget(self, action: #selector(textDidChangeAction), for: .valueChanged)
        searchTextFieldContrainerView.addSubview(searchTextField)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDSearchBar {
    
    func addConstraints() {
        addSearchTextFieldContrainerViewConstraints()
        addSearchTextFieldConstraints()
    }
    
    func addSearchTextFieldContrainerViewConstraints() {
        
    }
    
    func addSearchTextFieldConstraints() {
        
    }

}

// MARK: - Drop Shadow
fileprivate extension MDSearchBar {
    
    func dropShadow() {
        
    }
    
}

// MARK: - Actions
fileprivate extension MDSearchBar {
    
    @objc func textDidChangeAction(_ sender: UITextField) {
        delegate?.searchBar(self, textDidChange: sender.text)
    }
    
}
