//
//  AccountViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 21.09.2021.

import UIKit

final class AccountViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: AccountPresenterInputProtocol
    
    fileprivate static let nicknameTitleLabelHeight: CGFloat = 18
    fileprivate static let nicknameTitleLabelFont: UIFont = MDAppStyling.Font.MyriadProSemiBold.font()
    fileprivate static let nicknameTitleLabelNumberOfLines: Int = 1
    fileprivate static let nicknameTitleLabelLeftOffset: CGFloat = 16
    fileprivate let nicknameTitleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = nicknameTitleLabelFont
        label.textColor = MDAppStyling.Color.md_C7C7CC.color()
        label.textAlignment = .left
        label.text = KeysForTranslate.nickname.localized + MDConstants.StaticText.colon
        label.numberOfLines = nicknameTitleLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let nicknameDetailLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDAppStyling.Font.MyriadProSemiBold.font()
        label.textColor = MDAppStyling.Color.md_3C3C3C.color()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(presenter: AccountPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: KeysForTranslate.account.localized,
                   navigationBarBackgroundImage: MDAppStyling.Image.background_navigation_bar_2.image)
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
        self.nicknameDetailLabel.text = text
    }
    
    func showError(_ error: Error) {
        UIAlertController.showAlertWithOkAction(title: KeysForTranslate.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
    }
    
}

// MARK: - Add Views
fileprivate extension AccountViewController {
    
    func addViews() {
        addNicknameTitleLabel()
        addNicknameDetailLabel()
    }
    
    func addNicknameTitleLabel() {
        view.addSubview(nicknameTitleLabel)
    }
    
    func addNicknameDetailLabel() {
        view.addSubview(nicknameDetailLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AccountViewController {
    
    func addConstraints() {
        addNicknameTitleLabelConstraints()
        addNicknameDetailLabeConstraintsl()
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
                                                   constant: Self.nicknameTitleLabelWidth(fromText: KeysForTranslate.nickname.localized))
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.nicknameTitleLabel,
                                                    constant: Self.nicknameTitleLabelHeight)
        
    }
    
    func addNicknameDetailLabeConstraintsl() {
        
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
    
}

// MARK: - Configure UI
fileprivate extension AccountViewController {
    
    func configureUI() {
        configureSelfView()
    }
    
    func configureSelfView() {
        self.view.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor()
    }
    
}

// MARK: - Drop Shadow
fileprivate extension AccountViewController {
    
    func dropShadow() {
        
    }
    
}

// MARK: - Round Off Edges
fileprivate extension AccountViewController {
    
    func roundOffEdges() {
        
    }
    
}

// MARK: - Actions
fileprivate extension AccountViewController {
    
}

// MARK: - Nickname Title Label Width
fileprivate extension AccountViewController {
    
    static func nicknameTitleLabelWidth(fromText text: String) -> CGFloat {
        return text.widthFromLabel(font: Self.nicknameTitleLabelFont,
                                   height: Self.nicknameTitleLabelHeight,
                                   numberOfLines: Self.nicknameTitleLabelNumberOfLines) + Self.nicknameTitleLabelLeftOffset
    }
    
}
