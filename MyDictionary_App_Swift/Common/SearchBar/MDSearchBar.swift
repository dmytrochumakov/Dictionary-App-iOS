//
//  MDSearchBar.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 19.09.2021.
//

import UIKit

protocol MDSearchBarDelegate: AnyObject {
    func searchBarShouldClear(_ searchBar: MDSearchBar)
    func searchBarCancelButtonClicked(_ searchBar: MDSearchBar)
    func searchBarSearchButtonClicked(_ searchBar: MDSearchBar)
    func searchBar(_ searchBar: MDSearchBar, textDidChange searchText: String?)
}

final class MDSearchBar: UIView {
        
    fileprivate let searchTextFieldContrainerView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate static let searchTextFieldHeight: CGFloat = 40
    fileprivate static let searchTextFieldLeftOffset: CGFloat = 16
    fileprivate static let searchTextFieldRightOffset: CGFloat = 16
    fileprivate let searchTextField: MDSearchTextField = {
        let textField: MDSearchTextField = .init()
        textField.placeholder = KeysForTranslate.search.localized        
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
        roundOffEdges()
        dropShadow()
    }
    
}

// MARK: - UITextFieldDelegate
extension MDSearchBar: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.searchBarShouldClear(self)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchBarSearchButtonClicked(self)
        return true
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
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textDidChangeAction), for: .editingChanged)
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
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.searchTextFieldContrainerView,
                                                         toItem: self)
        
    }
    
    func addSearchTextFieldConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.searchTextField,
                                                     toItem: self.searchTextFieldContrainerView,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.searchTextField,
                                                  toItem: self.searchTextFieldContrainerView,
                                                  constant: Self.searchTextFieldLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.searchTextField,
                                                   toItem: self.searchTextFieldContrainerView,
                                                   constant: -Self.searchTextFieldRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.searchTextField,
                                                    constant: Self.searchTextFieldHeight)
        
    }
    
}

// MARK: - Round Off Edges
fileprivate extension MDSearchBar {
    
    func roundOffEdges() {
        searchTextFieldRoundOffEdges()
    }
    
    func searchTextFieldRoundOffEdges() {
        searchTextField.layer.cornerRadius = 10
    }
    
}

// MARK: - Drop Shadow
fileprivate extension MDSearchBar {
    
    func dropShadow() {
        dropShadowSearchTextField()
    }
    
    func dropShadowSearchTextField() {
        searchTextField.dropShadow(color: MDAppStyling.Color.md_Blue_4400D4_Light_Appearence.color(0.5),
                                   offSet: .init(width: 2,
                                                 height: 4),
                                   radius: 10)
    }
    
}

// MARK: - Actions
fileprivate extension MDSearchBar {
    
    @objc func textDidChangeAction(_ sender: UITextField) {
        delegate?.searchBar(self, textDidChange: sender.text)
    }
    
}
