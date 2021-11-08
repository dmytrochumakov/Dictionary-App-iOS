//
//  AddWordViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 27.09.2021.

import UIKit

final class AddWordViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: AddWordPresenterInputProtocol
    
    fileprivate var keyboardHandler: KeyboardHandler!
    
    fileprivate static let wordTextFieldHeight: CGFloat = 48
    fileprivate static let wordTextFieldTopOffset: CGFloat = 24
    fileprivate static let wordTextFieldLeftOffset: CGFloat = 16
    fileprivate static let wordTextFieldRightOffset: CGFloat = 16
    fileprivate let wordTextField: MDCounterTextFieldWithToolBar = {
        let textField: MDCounterTextFieldWithToolBar = MDCounterTextFieldWithToolBar.init(rectInset: MDConstants.Rect.defaultInset,
                                                                                          keyboardToolbar: MDKeyboardToolbar.init())
        textField.placeholder = MDLocalizedText.wordText.localized
        textField.autocorrectionType = .no
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.font = MDUIResources.Font.MyriadProItalic.font()
        textField.textColor = MDUIResources.Color.md_3C3C3C.color()
        textField.returnKeyType = .next
        textField.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.updateCounter(currentCount: .zero, maxCount: MDConstants.Text.MaxCountCharacters.wordTextField)
        return textField
    }()
    
    fileprivate static let wordDescriptionTextViewTopOffset: CGFloat = 16
    fileprivate static let wordDescriptionTextViewLeftOffset: CGFloat = 16
    fileprivate static let wordDescriptionTextViewRightOffset: CGFloat = 16
    fileprivate static let wordDescriptionTextViewHeightOffset: CGFloat = 290
    fileprivate let wordDescriptionTextView: MDTextViewWithToolBar = {
        let textView: MDTextViewWithToolBar = .init(keyboardToolbar: .init())
        textView.placeholder = MDLocalizedText.wordDescription.localized
        textView.autocorrectionType = .no
        textView.textAlignment = .left
        textView.font = MDUIResources.Font.MyriadProItalic.font()
        textView.textColor = MDUIResources.Color.md_3C3C3C.color()
        textView.backgroundColor = MDUIResources.Color.md_FFFFFF.color()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.keyboardDismissMode = .interactive
        return textView
    }()
    
    fileprivate static let wordDescriptionCounterLabelTopOffset: CGFloat = 4
    fileprivate static let wordDescriptionCounterLabelLeftOffset: CGFloat = .zero
    fileprivate static let wordDescriptionCounterLabelRightOffset: CGFloat = 4
    fileprivate let wordDescriptionCounterLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font(ofSize: 11)
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    fileprivate static let addButtonHeight: CGFloat = 48
    fileprivate static let addButtonTopOffset: CGFloat = 16
    fileprivate static let addButtonLeftOffset: CGFloat = 16
    fileprivate static let addButtonRightOffset: CGFloat = 16
    fileprivate let addButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_4400D4.color()
        button.setTitle(MDLocalizedText.add.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(presenter: AddWordPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: MDLocalizedText.addWord.localized,
                   navigationBarBackgroundImage: MDUIResources.Image.background_navigation_bar_1.image)
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
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
        roundOffEdges()
        dropShadow()
    }
    
}

// MARK: - AddWordPresenterOutputProtocol
extension AddWordViewController: AddWordPresenterOutputProtocol {
    
    func makeWordDescriptionTextViewActive() {
        wordDescriptionTextView.becomeFirstResponder()
    }
    
    func updateWordTextFieldCounter(_ count: Int) {
        wordTextField.updateCounter(currentCount: count,
                                    maxCount: MDConstants.Text.MaxCountCharacters.wordTextField)
    }
    
    func wordTextFieldShouldClearAction() {
        wordTextField.updateCounter(currentCount: .zero,
                                    maxCount: MDConstants.Text.MaxCountCharacters.wordTextField)
    }
    
    func updateWordTextViewCounter(_ count: Int) {
        //
        updateWordDescriptionCounterLabel(currentCount: count,
                                          maxCount: MDConstants.Text.MaxCountCharacters.wordDescriptionTextView)
        //
    }
    
    func showError(_ error: Error) {
        
        UIAlertController.showAlertWithOkAction(title: MDLocalizedText.error.localized,
                                                message: error.localizedDescription,
                                                presenter: self)
        
    }
    
    func showProgressHUD() {
        MDConstants.MDNetworkActivityIndicator.show()
    }
    
    func hideProgressHUD() {
        MDConstants.MDNetworkActivityIndicator.hide()
    }
    
}

// MARK: - Add Views
fileprivate extension AddWordViewController {
    
    func addViews() {
        bringSubviewsToFront()
        addWordTextField()
        addWordDescriptionTextView()
        addWordDescriptionCounterLabel()
        addAddButton()
    }
    
    func bringSubviewsToFront() {
        view.bringSubviewToFront(navigationBarView)
        view.bringSubviewToFront(navigationBarBackgroundImageView)
        view.bringSubviewToFront(backButton)
        view.bringSubviewToFront(titleLabel)
    }
    
    func addWordTextField() {
        wordTextField.addTarget(self, action: #selector(wordTextFieldDidChange), for: .editingChanged)
        wordTextField.delegate = presenter.textFieldDelegate
        view.addSubview(wordTextField)
    }
    
    func addWordDescriptionTextView() {
        wordDescriptionTextView.delegate = presenter.textViewDelegate
        view.addSubview(wordDescriptionTextView)
        view.sendSubviewToBack(wordDescriptionTextView)
    }
    
    func addWordDescriptionCounterLabel() {
        view.addSubview(wordDescriptionCounterLabel)
    }
    
    func addAddButton() {
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AddWordViewController {
    
    func addConstraints() {
        addWordTextFieldConstraints()
        addWordDescriptionTextViewConstraints()
        addWordDescriptionCounterLabelConstraints()
        addAddButtonConstraints()
    }
    
    func addWordTextFieldConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.wordTextField,
                                              attribute: .top,
                                              toItem: self.navigationBarView,
                                              attribute: .bottom,
                                              constant: Self.wordTextFieldTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.wordTextField,
                                                  toItem: self.view,
                                                  constant: Self.wordTextFieldLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.wordTextField,
                                                   toItem: self.view,
                                                   constant: -Self.wordTextFieldRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.wordTextField,
                                                    constant: Self.wordTextFieldHeight)
        
    }
    
    func addWordDescriptionTextViewConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.wordDescriptionTextView,
                                              attribute: .top,
                                              toItem: self.wordTextField,
                                              attribute: .bottom,
                                              constant: Self.wordDescriptionTextViewTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.wordDescriptionTextView,
                                                  toItem: self.view,
                                                  constant: Self.wordDescriptionTextViewLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.wordDescriptionTextView,
                                                   toItem: self.view,
                                                   constant: -Self.wordDescriptionTextViewRightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.wordDescriptionTextView,
                                                    constant: Self.wordDescriptionTextViewHeightOffset)
        
    }
    
    func addWordDescriptionCounterLabelConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.wordDescriptionCounterLabel,
                                              attribute: .top,
                                              toItem: self.wordDescriptionTextView,
                                              attribute: .bottom,
                                              constant: 4)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.wordDescriptionCounterLabel,
                                                  toItem: self.wordDescriptionTextView,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.wordDescriptionCounterLabel,
                                                   toItem: self.wordDescriptionTextView,
                                                   constant: -4)
        
    }
    
    func addAddButtonConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.addButton,
                                                  toItem: self.view,
                                                  constant: Self.addButtonLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.addButton,
                                                   toItem: self.view,
                                                   constant: -Self.addButtonRightOffset)
        
        NSLayoutConstraint.addEqualConstraint(item: self.addButton,
                                              attribute: .top,
                                              toItem: self.wordDescriptionTextView,
                                              attribute: .bottom,
                                              constant: Self.addButtonTopOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.addButton,
                                                    constant: Self.addButtonHeight)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension AddWordViewController {
    
    func configureUI() {
        configureWordDescriptionCounterLabel()
        createKeyboardHandler()
    }
    
    func configureWordDescriptionCounterLabel() {
        updateWordDescriptionCounterLabel(currentCount: .zero,
                                          maxCount: MDConstants.Text.MaxCountCharacters.wordDescriptionTextView)
    }
    
    func createKeyboardHandler() {
        self.keyboardHandler = KeyboardHandler.createKeyboardHandler(scrollView: self.wordDescriptionTextView)
    }
    
}

// MARK: - Drop Shadow
fileprivate extension AddWordViewController {
    
    func dropShadow() {
        dropShadowWordTextField()
        dropShadowWordDescriptionTextView()
        dropShadowAddButton()
    }
    
    func dropShadowWordTextField() {
        wordTextField.dropShadow(color: MDUIResources.Color.md_5200FF.color(0.5),
                                 offSet: .init(width: 2, height: 4),
                                 radius: 15)
    }
    
    func dropShadowWordDescriptionTextView() {
        wordDescriptionTextView.dropShadow(color: MDUIResources.Color.md_5200FF.color(0.5),
                                           offSet: .init(width: 2, height: 4),
                                           radius: 15)
    }
    
    func dropShadowAddButton() {
        addButton.dropShadow(color: MDUIResources.Color.md_4400D4.color(0.5),
                             offSet: .init(width: 0, height: 4),
                             radius: 10)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension AddWordViewController {
    
    func roundOffEdges() {
        roundOffEdgesWordTextField()
        roundOffEdgesWordDescriptionTextView()
        roundOffEdgesAddButton()
    }
    
    func roundOffEdgesWordTextField() {
        wordTextField.layer.cornerRadius = 10
    }
    
    func roundOffEdgesWordDescriptionTextView() {
        wordDescriptionTextView.layer.cornerRadius = 10
    }
    
    func roundOffEdgesAddButton() {
        addButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Actions
fileprivate extension AddWordViewController {
    
    @objc func addButtonAction() {
        presenter.addButtonClicked()
    }
    
    @objc func wordTextFieldDidChange(_ sender: UITextField) {
        presenter.wordTextFieldDidChange(sender.text)
    }
    
}

// MARK: - Update Counter
fileprivate extension AddWordViewController {
    
    func updateWordDescriptionCounterLabel(currentCount: Int, maxCount: Int) {
        wordDescriptionCounterLabel.text = MDConstants.Text.Counter.text(currentCount: currentCount, maxCount: maxCount)
    }
    
}
