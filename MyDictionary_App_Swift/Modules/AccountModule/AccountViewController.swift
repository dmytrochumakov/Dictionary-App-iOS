//
//  AccountViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

final class AccountViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: AccountPresenterInputProtocol
    
    fileprivate static let nicknameTitleLabelHeight: CGFloat = 18
    fileprivate static let nicknameTitleLabelFont: UIFont = MDUIResources.Font.MyriadProSemiBold.font()
    fileprivate static let nicknameTitleLabelNumberOfLines: Int = 1
    fileprivate static let nicknameTitleLabelLeftOffset: CGFloat = 16
    fileprivate let nicknameTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = nicknameTitleLabelFont
        label.textColor = MDUIResources.Color.md_C7C7CC.color()
        label.textAlignment = .left
        label.text = MDLocalizedText.nickname.localized + MDConstants.StaticText.colon
        label.numberOfLines = nicknameTitleLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let nicknameDetailLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProSemiBold.font()
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate static let logOutButtonHeight: CGFloat = 48
    fileprivate let logOutButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_4400D4.color()
        button.setTitle(MDLocalizedText.logOut.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate static let deleteAccountButtonHeight: CGFloat = 48
    fileprivate let deleteAccountButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_FF3B30.color()
        button.setTitle(MDLocalizedText.delete.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProSemiBold.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let hud: MDProgressHUDHelperProtocol = {
        return MDProgressHUDHelper.init()
    }()
    
    init(presenter: AccountPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: MDLocalizedText.account.localized,
                   navigationBarBackgroundImage: MDUIResources.Image.background_navigation_bar_2.image)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        addViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
        roundOffEdges()
        dropShadow()
    }
    
}

// MARK: - AccountPresenterOutputProtocol
extension AccountViewController: AccountPresenterOutputProtocol {
    
    func updateNicknameText(_ text: String) {
        DispatchQueue.main.async {
            self.nicknameDetailLabel.text = text
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showAlertWithOkAction(title: MDLocalizedText.error.localized,
                                                    message: error.localizedDescription,
                                                    presenter: self)
        }
    }
    
    func showProgressHUD() {
        DispatchQueue.main.async {
            self.hud.showProgressHUD(withConfiguration: .init(view: self.view))
        }
    }
    
    func hideProgressHUD() {
        DispatchQueue.main.async {
            self.hud.hideProgressHUD(animated: true)
        }
    }
    
}

// MARK: - Add Views
fileprivate extension AccountViewController {
    
    func addViews() {
        addNicknameTitleLabel()
        addNicknameDetailLabel()
        addLogOutButton()
        addDeleteAccountButton()
    }
    
    func addNicknameTitleLabel() {
        view.addSubview(nicknameTitleLabel)
    }
    
    func addNicknameDetailLabel() {
        view.addSubview(nicknameDetailLabel)
    }
    
    func addLogOutButton() {
        logOutButton.addTarget(self, action: #selector(logOutButtonAction), for: .touchUpInside)
        view.addSubview(logOutButton)
    }
    
    func addDeleteAccountButton() {
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonAction), for: .touchUpInside)
        view.addSubview(deleteAccountButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AccountViewController {
    
    func addConstraints() {
        addNicknameTitleLabelConstraints()
        addNicknameDetailLabelConstraints()
        addLogOutButtonConstraints()
        addDeleteAccountButtonConstraints()
    }
    
    func addNicknameTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.nicknameTitleLabel,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: 24)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.nicknameTitleLabel,
                                                  toItem: self.view,
                                                  constant: Self.nicknameTitleLabelLeftOffset)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.nicknameTitleLabel,
                                                   constant: Self.nicknameTitleLabelWidth(fromText: MDLocalizedText.nickname.localized))
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.nicknameTitleLabel,
                                                    constant: Self.nicknameTitleLabelHeight)
        
    }
    
    func addNicknameDetailLabelConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.nicknameDetailLabel,
                                              attribute: .left,
                                              toItem: self.nicknameTitleLabel,
                                              attribute: .right,
                                              constant: .zero)
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.nicknameDetailLabel,
                                                     toItem: self.nicknameTitleLabel,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.nicknameDetailLabel,
                                                   toItem: self.view,
                                                   constant: -16)
        
        
    }
    
    func addLogOutButtonConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.logOutButton,
                                                  toItem: self.view,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.logOutButton,
                                                   toItem: self.view,
                                                   constant: -16)
        
        NSLayoutConstraint.addEqualConstraint(item: self.logOutButton,
                                              attribute: .bottom,
                                              toItem: self.deleteAccountButton,
                                              attribute: .top,
                                              constant: -16)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.logOutButton,
                                                    constant: Self.logOutButtonHeight)
        
    }
    
    func addDeleteAccountButtonConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.deleteAccountButton,
                                                  toItem: self.view,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.deleteAccountButton,
                                                   toItem: self.view,
                                                   constant: -16)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.deleteAccountButton,
                                                    toItem: self.view,
                                                    constant: -24)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.deleteAccountButton,
                                                    constant: Self.deleteAccountButtonHeight)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension AccountViewController {
    
    func configureUI() {
        configureSelfView()
    }
    
    func configureSelfView() {
        self.view.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
    }
    
}

// MARK: - Drop Shadow
fileprivate extension AccountViewController {
    
    func dropShadow() {
        dropShadowLogOutButton()
        dropShadowDeleteAccountButton()
    }
    
    func dropShadowLogOutButton() {
        logOutButton.dropShadow(color: MDUIResources.Color.md_4400D4.color(0.5),
                                offSet: .init(width: 0, height: 4),
                                radius: 10)
    }
    
    func dropShadowDeleteAccountButton() {
        deleteAccountButton.dropShadow(color: MDUIResources.Color.md_FF3B30.color(0.5),
                                       offSet: .init(width: 0, height: 4),
                                       radius: 10)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension AccountViewController {
    
    func roundOffEdges() {
        logOutButtonRoundOffEdges()
        deleteAccountButtonRoundOffEdges()
    }
    
    func logOutButtonRoundOffEdges() {
        logOutButton.layer.cornerRadius = 10
    }
    
    func deleteAccountButtonRoundOffEdges() {
        deleteAccountButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Actions
fileprivate extension AccountViewController {
    
    @objc func logOutButtonAction() {
        presenter.logOutButtonClicked()
    }
    
    @objc func deleteAccountButtonAction() {
        presenter.deleteAccountButtonClicked()
    }
    
}

// MARK: - Nickname Title Label Width
fileprivate extension AccountViewController {
    
    static func nicknameTitleLabelWidth(fromText text: String) -> CGFloat {
        return text.widthFromLabel(font: Self.nicknameTitleLabelFont,
                                   height: Self.nicknameTitleLabelHeight,
                                   numberOfLines: Self.nicknameTitleLabelNumberOfLines) + Self.nicknameTitleLabelLeftOffset
    }
    
}
