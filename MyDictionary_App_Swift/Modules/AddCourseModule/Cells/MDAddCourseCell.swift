//
//  MDAddCourseCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import UIKit

final class MDAddCourseCell: UICollectionViewCell,
                             MDReuseIdentifierProtocol {
    
    public static let height: CGFloat = 56
    
    fileprivate let translatedLanguageNameLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font()
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let languageNameLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font(ofSize: 15)
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate static let checkboxImageViewSize: CGSize = .init(width: 24, height: 24)
    fileprivate let checkboxImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image(isSelected: false)
        imageView.contentMode = .center
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            self.updateCheckboxImage(isSelected: self.isSelected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
}

// MARK: - MDFillWithModelProtocol
extension MDAddCourseCell: MDFillWithModelProtocol {
    
    typealias Model = MDAddCourseRow?
    
    func fillWithModel(_ model: MDAddCourseRow?) {
        self.translatedLanguageNameLabel.text = model?.languageResponse.translatedName
        self.languageNameLabel.text = model?.languageResponse.name
    }
    
}

// MARK: - Add Views
fileprivate extension MDAddCourseCell {
    
    func addViews() {
        addTranslatedLanguageNameLabel()
        addLanguageNameLabel()
        addCheckboxImageView()
    }
    
    func addTranslatedLanguageNameLabel() {
        addSubview(translatedLanguageNameLabel)
    }
    
    func addLanguageNameLabel() {
        addSubview(languageNameLabel)
    }
    
    func addCheckboxImageView() {
        addSubview(checkboxImageView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDAddCourseCell {
    
    func addConstraints() {
        addTranslatedLanguageNameLabelConstraints()
        addTitleLabelConstraints()
        addCheckboxImageViewConstraints()
    }
    
    func addTranslatedLanguageNameLabelConstraints() {
        
        NSLayoutConstraint.addEqualTopConstraint(item: self.translatedLanguageNameLabel,
                                                 toItem: self,
                                                 constant: 8)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.translatedLanguageNameLabel,
                                                  toItem: self,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualConstraint(item: self.translatedLanguageNameLabel,
                                              attribute: .right,
                                              toItem: self.checkboxImageView,
                                              attribute: .left,
                                              constant: -16)
        
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.languageNameLabel,
                                              attribute: .top,
                                              toItem: self.translatedLanguageNameLabel,
                                              attribute: .bottom,
                                              constant: 8)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.languageNameLabel,
                                                  toItem: self,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualConstraint(item: self.languageNameLabel,
                                              attribute: .right,
                                              toItem: self.checkboxImageView,
                                              attribute: .left,
                                              constant: -16)
        
    }
    
    func addCheckboxImageViewConstraints() {
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.checkboxImageView,
                                                   toItem: self,
                                                   constant: -16)
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.checkboxImageView,
                                                     toItem: self,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.checkboxImageView,
                                                    constant: Self.checkboxImageViewSize.height)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.checkboxImageView,
                                                   constant: Self.checkboxImageViewSize.width)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension MDAddCourseCell {
    
    func configureUI() {
        configureSelfView()
    }
    
    func configureSelfView() {
        self.backgroundColor = .clear
    }
    
}

// MARK: - Private Methods
fileprivate extension MDAddCourseCell {
    
    func updateCheckboxImage(isSelected: Bool) {
        self.checkboxImageView.image = Self.image(isSelected: isSelected)
    }
    
    static func image(isSelected: Bool) -> UIImage {
        if (isSelected) {
            return MDUIResources.Image.checkbox_selected.image
        } else {
            return MDUIResources.Image.checkbox_unselected.image
        }
    }
    
}
