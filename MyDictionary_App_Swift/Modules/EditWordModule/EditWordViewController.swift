//
//  EditWordViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 28.09.2021.

import MBProgressHUD
import UIKit

final class EditWordViewController: MDBaseTitledBackNavigationBarViewController {
    
    fileprivate let presenter: EditWordPresenterInputProtocol
    
    fileprivate var keyboardHandler: KeyboardHandler!
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView: UIScrollView = .init()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let editWordButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(MDEditWordViewControllerConfiguration.EditWordButton.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    fileprivate var wordDescriptionTextViewTopConstraint: NSLayoutConstraint!
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
        return textView
    }()
    
    fileprivate let wordDescriptionCounterLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font(ofSize: 11)
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    fileprivate let updateButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_4400D4.color()
        button.setTitle(MDLocalizedText.update.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let deleteButton: UIButton = {
        let button: UIButton = .init()
        button.backgroundColor = MDUIResources.Color.md_FF3B30.color()
        button.setTitle(MDLocalizedText.delete.localized, for: .normal)
        button.setTitleColor(MDUIResources.Color.md_FFFFFF.color(), for: .normal)
        button.titleLabel?.font = MDUIResources.Font.MyriadProRegular.font()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(presenter: EditWordPresenterInputProtocol) {
        self.presenter = presenter
        super.init(title: presenter.getWordText,
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
        addConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundOffEdges()
        dropShadow()
    }
    
}

// MARK: - EditWordPresenterOutputProtocol
extension EditWordViewController: EditWordPresenterOutputProtocol {
    
    func updateVisibilityViews() {
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
            
            //
            self.wordTextField.isHidden = MDEditWordViewControllerConfiguration.WordTextField.isHidden(editButtonIsSelected: self.presenter.editButtonIsSelected)
            //
            self.updateButton.isHidden = MDEditWordViewControllerConfiguration.UpdateButton.isHidden(editButtonIsSelected: self.presenter.editButtonIsSelected)
            //
            self.deleteButton.isHidden = MDEditWordViewControllerConfiguration.DeleteButton.isHidden(editButtonIsSelected: self.presenter.editButtonIsSelected)
            //
            self.editWordButton.isHidden = MDEditWordViewControllerConfiguration.EditWordButton.isHidden(editButtonIsSelected: self.presenter.editButtonIsSelected)
            //
            
        }, completion: nil)
        
    }
    
    func updateWordDescriptionTextViewTopConstraint() {
        
        UIView.animate(withDuration: 0.05,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
            
            //
            self.wordDescriptionTextViewTopConstraint.constant =  MDEditWordViewControllerConfiguration.WordDescriptionTextView.topOffset(editButtonIsSelected: self.presenter.editButtonIsSelected,
                                                                                                                                          navigationController: self.navigationController)
            //
            self.view.layoutIfNeeded()
            //
            
        }, completion: nil)
        
    }
    
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
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showAlertWithOkAction(title: MDLocalizedText.error.localized,
                                                    message: error.localizedDescription,
                                                    presenter: self)
        }
    }
    
}

// MARK: - Add Views
fileprivate extension EditWordViewController {
    
    func addViews() {
        addScrollView()
        addContentView()
        bringSubviewsToFront()
        addEditWordButton()
        addWordTextField()
        addWordDescriptionTextView()
        addWordDescriptionCounterLabel()
        addUpdateButton()
        addDeleteButton()
    }
    
    func bringSubviewsToFront() {
        view.bringSubviewToFront(navigationBarView)
        view.bringSubviewToFront(navigationBarBackgroundImageView)
        view.bringSubviewToFront(backButton)
        view.bringSubviewToFront(titleLabel)
    }
    
    func addScrollView() {
        view.addSubview(scrollView)
    }
    
    func addContentView() {
        scrollView.addSubview(contentView)
    }
    
    func addEditWordButton() {
        editWordButton.addTarget(self, action: #selector(editWordButtonAction), for: .touchUpInside)
        view.addSubview(editWordButton)
    }
    
    func addWordTextField() {
        //        wordTextField.addTarget(self, action: #selector(wordTextFieldDidChange), for: .editingChanged)
        //        wordTextField.delegate = presenter.textFieldDelegate
        contentView.addSubview(wordTextField)
    }
    
    func addWordDescriptionTextView() {
        //        wordDescriptionTextView.delegate = presenter.textViewDelegate
        contentView.addSubview(wordDescriptionTextView)
        contentView.sendSubviewToBack(wordDescriptionTextView)
    }
    
    func addWordDescriptionCounterLabel() {
        contentView.addSubview(wordDescriptionCounterLabel)
    }
    
    func addUpdateButton() {
        updateButton.addTarget(self, action: #selector(updateButtonAction), for: .touchUpInside)
        contentView.addSubview(updateButton)
    }
    
    func addDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        contentView.addSubview(deleteButton)
    }
    
}

// MARK: - Add Constraints
fileprivate extension EditWordViewController {
    
    func addConstraints() {
        addScrollViewConstraints()
        addContentViewConstraints()
        addEditWordButtonConstraints()
        addWordTextFieldConstraints()
        addWordDescriptionTextViewConstraints()
        addWordDescriptionCounterLabelConstraints()
        addUpdateButtonConstraints()
        addDeleteButtonConstraints()
    }
    
    func addScrollViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.scrollView,
                                                         toItem: self.view)
        
    }
    
    func addContentViewConstraints() {
        
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.contentView,
                                                         toItem: self.scrollView)
        
        NSLayoutConstraint.addEqualCenterXConstraint(item: self.contentView,
                                                     toItem: self.scrollView,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.contentView,
                                                     toItem: self.scrollView,
                                                     constant: .zero)
        
    }
    
    func addEditWordButtonConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.editWordButton,
                                                     toItem: self.backButton,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.editWordButton,
                                                   toItem: self.navigationBarView,
                                                   constant: -MDEditWordViewControllerConfiguration.EditWordButton.rightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.editWordButton,
                                                    constant: MDEditWordViewControllerConfiguration.EditWordButton.size.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.editWordButton,
                                                   constant: MDEditWordViewControllerConfiguration.EditWordButton.size.width)
        
    }
    
    func addWordTextFieldConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.wordTextField,
                                              attribute: .top,
                                              toItem: self.contentView,
                                              attribute: .top,
                                              constant: MDEditWordViewControllerConfiguration.WordTextField.topOffset(fromNavigationController: navigationController))
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.wordTextField,
                                                  toItem: self.contentView,
                                                  constant: MDEditWordViewControllerConfiguration.WordTextField.leftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.wordTextField,
                                                   toItem: self.contentView,
                                                   constant: -MDEditWordViewControllerConfiguration.WordTextField.rightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.wordTextField,
                                                    constant: MDEditWordViewControllerConfiguration.WordTextField.height)
        
    }
    
    func addWordDescriptionTextViewConstraints() {
        
        self.wordDescriptionTextViewTopConstraint = NSLayoutConstraint.addEqualConstraint(item: self.wordDescriptionTextView,
                                                                                          attribute: .top,
                                                                                          toItem: self.contentView,
                                                                                          attribute: .top,
                                                                                          constant: MDEditWordViewControllerConfiguration.WordDescriptionTextView.topOffset(editButtonIsSelected: presenter.editButtonIsSelected,
                                                                                                                                                                            navigationController: navigationController))
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.wordDescriptionTextView,
                                                  toItem: self.contentView,
                                                  constant: MDEditWordViewControllerConfiguration.WordDescriptionTextView.leftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.wordDescriptionTextView,
                                                   toItem: self.contentView,
                                                   constant: -MDEditWordViewControllerConfiguration.WordDescriptionTextView.rightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.wordDescriptionTextView,
                                                    constant: MDEditWordViewControllerConfiguration.WordDescriptionTextView.height)
        
    }
    
    func addWordDescriptionCounterLabelConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.wordDescriptionCounterLabel,
                                              attribute: .top,
                                              toItem: self.wordDescriptionTextView,
                                              attribute: .bottom,
                                              constant: MDEditWordViewControllerConfiguration.WordDescriptionCounterLabel.topOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.wordDescriptionCounterLabel,
                                                  toItem: self.wordDescriptionTextView,
                                                  constant: MDEditWordViewControllerConfiguration.WordDescriptionCounterLabel.leftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.wordDescriptionCounterLabel,
                                                   toItem: self.wordDescriptionTextView,
                                                   constant: -MDEditWordViewControllerConfiguration.WordDescriptionCounterLabel.rightOffset)
        
    }
    
    func addUpdateButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.updateButton,
                                              attribute: .top,
                                              toItem: self.wordDescriptionTextView,
                                              attribute: .bottom,
                                              constant: MDEditWordViewControllerConfiguration.UpdateButton.topOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.updateButton,
                                                  toItem: self.contentView,
                                                  constant: MDEditWordViewControllerConfiguration.UpdateButton.leftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.updateButton,
                                                   toItem: self.contentView,
                                                   constant: -MDEditWordViewControllerConfiguration.UpdateButton.rightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.updateButton,
                                                    constant: MDEditWordViewControllerConfiguration.UpdateButton.height)
        
    }
    
    func addDeleteButtonConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.deleteButton,
                                              attribute: .top,
                                              toItem: self.updateButton,
                                              attribute: .bottom,
                                              constant: MDEditWordViewControllerConfiguration.DeleteButton.topOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.deleteButton,
                                                  toItem: self.contentView,
                                                  constant: MDEditWordViewControllerConfiguration.DeleteButton.leftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.deleteButton,
                                                   toItem: self.contentView,
                                                   constant: -MDEditWordViewControllerConfiguration.DeleteButton.rightOffset)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.deleteButton,
                                                    constant: MDEditWordViewControllerConfiguration.DeleteButton.height)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension EditWordViewController {
    
    func configureUI() {
        //
        configureWordDescriptionCounterLabel()
        //
        createKeyboardHandler()
        //
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
fileprivate extension EditWordViewController {
    
    func dropShadow() {
        dropShadowWordTextField()
        dropShadowWordDescriptionTextView()
        dropShadowUpdateButton()
        dropShadowDeleteButton()
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
    
    func dropShadowUpdateButton() {
        updateButton.dropShadow(color: MDUIResources.Color.md_4400D4.color(0.5),
                                offSet: .init(width: 0, height: 4),
                                radius: 10)
    }
    
    func dropShadowDeleteButton() {
        deleteButton.dropShadow(color: MDUIResources.Color.md_FF3B30.color(0.5),
                                offSet: .init(width: 0, height: 4),
                                radius: 10)
    }
    
}

// MARK: - Round Off Edges
fileprivate extension EditWordViewController {
    
    func roundOffEdges() {
        roundOffEdgesWordTextField()
        roundOffEdgesWordDescriptionTextView()
        roundOffEdgesUpdateButton()
        roundOffEdgesDeleteButton()
    }
    
    func roundOffEdgesWordTextField() {
        wordTextField.layer.cornerRadius = 10
    }
    
    func roundOffEdgesWordDescriptionTextView() {
        wordDescriptionTextView.layer.cornerRadius = 10
    }
    
    func roundOffEdgesUpdateButton() {
        updateButton.layer.cornerRadius = 10
    }
    
    func roundOffEdgesDeleteButton() {
        deleteButton.layer.cornerRadius = 10
    }
    
}

// MARK: - Actions
fileprivate extension EditWordViewController {
    
    @objc func editWordButtonAction() {
        presenter.editWordButtonClicked()
    }
    
    @objc func updateButtonAction() {
        presenter.updateButtonClicked()
    }
    
    @objc func deleteButtonAction() {
        presenter.deleteButtonClicked()
    }
    
}

// MARK: - Update Counter
fileprivate extension EditWordViewController {
    
    func updateWordDescriptionCounterLabel(currentCount: Int, maxCount: Int) {
        wordDescriptionCounterLabel.text = MDConstants.Text.Counter.text(currentCount: currentCount, maxCount: maxCount)
    }
    
}
