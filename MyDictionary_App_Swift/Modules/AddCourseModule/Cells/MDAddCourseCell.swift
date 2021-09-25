//
//  MDAddCourseCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import UIKit

final class MDAddCourseCell: UICollectionViewCell,
                             ReuseIdentifierProtocol {
    
    public static let height: CGFloat = 40
    
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font()
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
        self.titleLabel.text = model?.languageResponse.languageName
    }
    
}

// MARK: - Add Views
fileprivate extension MDAddCourseCell {
    
    func addViews() {
        addTitleLabel()
        addCheckboxImageView()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
    func addCheckboxImageView() {
        addSubview(checkboxImageView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDAddCourseCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
        addCheckboxImageViewConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .right,
                                              toItem: self.checkboxImageView,
                                              attribute: .left,
                                              constant: -16)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .centerY,
                                              toItem: self.checkboxImageView,
                                              attribute: .centerY,
                                              constant: .zero)
        
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
