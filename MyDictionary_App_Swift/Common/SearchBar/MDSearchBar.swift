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
    fileprivate static let searchTextFieldLeftOffset: CGFloat = 8
    fileprivate static let searchTextFieldRightOffset: CGFloat = 16
    fileprivate let searchTextField: MDSearchTextField = {
        let textField: MDSearchTextField = .init()
        textField.placeholder = LocalizedText.search.localized        
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.font = MDUIResources.Font.MyriadProRegular.font()
        textField.textColor = MDUIResources.Color.md_3C3C3C.color()
        textField.returnKeyType = .search
        textField.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    fileprivate static let cancelButtonHeight: CGFloat = 40
    fileprivate static let cancelButtonRightOffset: CGFloat = 8
    fileprivate static let cancelButtonFont: UIFont = MDUIResources.Font.MyriadProRegular.font()
    fileprivate let cancelButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = cancelButtonBackgroundColor(isActive: false)
        button.setTitle(LocalizedText.cancel.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = cancelButtonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Default is false
    fileprivate var cancelButtonIsActive: Bool
    
    public weak var delegate: MDSearchBarDelegate?
    
    override init(frame: CGRect = .zero) {
        self.cancelButtonIsActive = false
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activateViews()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.searchBarShouldClear(self)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        deactivateViews()
        delegate?.searchBarSearchButtonClicked(self)
        return true
    }
    
}

// MARK: - Add Views
fileprivate extension MDSearchBar {
    
    func addViews() {
        addSearchTextFieldContrainerView()
        addSearchTextField()
        addCancelButton()
    }
    
    func addSearchTextFieldContrainerView() {
        addSubview(searchTextFieldContrainerView)
    }
    
    func addSearchTextField() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textDidChangeAction), for: .editingChanged)
        searchTextFieldContrainerView.addSubview(searchTextField)
    }
    
    func addCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        searchTextFieldContrainerView.addSubview(cancelButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDSearchBar {
    
    func addConstraints() {
        addSearchTextFieldContrainerViewConstraints()
        addSearchTextFieldConstraints()
        addCancelButtonConstraints()
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
        
        NSLayoutConstraint.addEqualConstraint(item: self.searchTextField,
                                              attribute: .right,
                                              toItem: self.cancelButton,
                                              attribute: .left,
                                              constant: -Self.searchTextFieldRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.searchTextField,
                                                    constant: Self.searchTextFieldHeight)
        
    }
    
    func addCancelButtonConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.cancelButton,
                                                     toItem: self.searchTextFieldContrainerView,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.cancelButton,
                                                   toItem: self.searchTextFieldContrainerView,
                                                   constant: -Self.cancelButtonRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.cancelButton,
                                                    constant: Self.cancelButtonHeight)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.cancelButton,
                                                   constant: Self.cancelButtonWidth(fromText: LocalizedText.cancel.localized))
        
    }
    
}

// MARK: - Round Off Edges
fileprivate extension MDSearchBar {
    
    func roundOffEdges() {
        searchTextFieldRoundOffEdges()
        cancelButtonRoundOffEdges()
    }
    
    func searchTextFieldRoundOffEdges() {
        searchTextField.layer.cornerRadius = 10
    }
    
    func cancelButtonRoundOffEdges() {
        cancelButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Drop Shadow
fileprivate extension MDSearchBar {
    
    func dropShadow() {
        dropShadowSearchTextField()
        dropShadowCancelButton(isActive: false)
    }
    
    func dropShadowSearchTextField() {
        searchTextField.dropShadow(color: MDUIResources.Color.md_4400D4.color(0.5),
                                   offSet: .init(width: 2,
                                                 height: 4),
                                   radius: 10)
    }
    
    func dropShadowCancelButton(isActive: Bool) {
        cancelButton.dropShadow(color: Self.cancelButtonShadowColor(isActive: isActive),
                                offSet: .init(width: 0,
                                              height: 4),
                                radius: 20)
    }
    
}

// MARK: - Actions
fileprivate extension MDSearchBar {
    
    @objc func textDidChangeAction(_ sender: UITextField) {
        delegate?.searchBar(self, textDidChange: sender.text)
    }
    
    @objc func cancelButtonAction() {
        if (cancelButtonIsActive) {
            deactivateViews()
            delegate?.searchBarCancelButtonClicked(self)
        } else {
            activateViews()
        }
    }
    
}

// MARK: - Activate Views
fileprivate extension MDSearchBar {
    
    func activateViews() {
        activateCancelButton()
        activateInputSearchTextField()
    }
    
    func activateCancelButton() {
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
                        
                        self.cancelButton.backgroundColor = Self.cancelButtonBackgroundColor(isActive: true)                        
                        self.dropShadowCancelButton(isActive: true)
                        
                       }, completion: nil)
        
        cancelButtonIsActive = true
        
    }
    
    func activateInputSearchTextField() {
        searchTextField.becomeFirstResponder()
    }
    
}

// MARK: - Deactivate Views
fileprivate extension MDSearchBar {
    
    func deactivateViews() {
        deactivateCancelButton()
        deactivateInputSearchTextField()
    }
    
    func deactivateCancelButton() {
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
                        
                        self.cancelButton.backgroundColor = Self.cancelButtonBackgroundColor(isActive: false)
                        self.dropShadowCancelButton(isActive: false)
                        
                       }, completion: nil)
        
        cancelButtonIsActive = false
        
    }
    
    func deactivateInputSearchTextField() {
        searchTextField.resignFirstResponder()
    }
    
}

// MARK: - Cancel Button Configuration
fileprivate extension MDSearchBar {
    
    static func cancelButtonWidth(fromText text: String) -> CGFloat {
        return text.widthFromLabel(font: Self.cancelButtonFont,
                                   height: Self.cancelButtonHeight,
                                   numberOfLines: 1) + 16
    }
    
    static func cancelButtonBackgroundColor(isActive: Bool) -> UIColor {
        if (isActive) {
            return MDUIResources.Color.md_4400D4.color()
        } else {
            return MDUIResources.Color.md_C7C7CC.color()
        }
    }
    
    static func cancelButtonShadowColor(isActive: Bool) -> UIColor {
        if (isActive) {
            return MDUIResources.Color.md_4400D4.color(0.5)
        } else {
            return MDUIResources.Color.md_C7C7CC.color()
        }
    }
    
}
