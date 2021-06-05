//
//  AppearanceCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import UIKit

final class AppearanceCell: UICollectionViewCell,
                            ReuseIdentifierProtocol {
    
    static let height: CGFloat = 40
    
    fileprivate let titleLabel: UILabel = {
        let titleLabel: UILabel = .init()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    fileprivate static let titleLabelConfiguration = StandardLabelConfigurationModel.init(font: AppStyling.Font.systemFont.font(),
                                                                                          textColor: AppStyling.labelTextColor(),
                                                                                          textAlignment: .left,
                                                                                          numberOfLines: .zero)
    
    fileprivate let imageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
}

// MARK: - FillWithModelProtocol
extension AppearanceCell: FillWithModelProtocol {
    
    typealias Model = AppearanceRowModel
    
    func fillWithModel(_ model: AppearanceRowModel) {
        self.updateTitleLabel(model)
        self.updateImageView(isSelected: model.isSelected)
    }
    
}

// MARK: - Add Views
fileprivate extension AppearanceCell {
    
    func addViews() {
        addTitleLabel()
        addImageView()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
    func addImageView() {
        addSubview(imageView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AppearanceCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
        addImageViewConstraints()
    }
    
    func addTitleLabelConstraints() {
        NSLayoutConstraint.addEqualTopConstraintAndActivate(item: titleLabel,
                                                            toItem: self,
                                                            constant: .zero)
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: titleLabel,
                                                             toItem: self,
                                                             constant: 16)
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: titleLabel,
                                                              toItem: self,
                                                              constant: .zero)
        NSLayoutConstraint.addEqualBottomConstraintAndActivate(item: titleLabel,
                                                               toItem: self,
                                                               constant: .zero)
    }
    
    func addImageViewConstraints() {
        NSLayoutConstraint.addEqualHeightConstraintAndActivate(item: imageView,
                                                               constant: 24)
        NSLayoutConstraint.addEqualWidthConstraintAndActivate(item: imageView,
                                                              constant: 24)
        NSLayoutConstraint.addEqualCenterYConstraintAndActivate(item: imageView,
                                                                toItem: self,
                                                                constant: .zero)
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: imageView,
                                                              toItem: self,
                                                              constant: .zero)
    }
    
}

// MARK: - Configure UI
fileprivate extension AppearanceCell {
    
    func configureUI() {
        configureView()
        configureTitleLabel()
        configureImageView()
    }
    
    func configureView() {
        updateSelfView()
    }
    
    func configureTitleLabel() {
        self.titleLabel.configure(withConfiguration: Self.titleLabelConfiguration)
    }
    
    func configureImageView() {
        updateImageView(isSelected: false)
    }
    
}

// MARK: - Update
fileprivate extension AppearanceCell {
    
    func updateSelfView() {
        self.backgroundColor = AppStyling.viewBackgroundColor()
    }
    
    func updateTitleLabel(_ model: AppearanceRowModel) {
        self.titleLabel.configure(withConfiguration: Self.titleLabelConfiguration,
                                  andText: model.titleText)
    }
    
    func updateImageView(isSelected: Bool) {
        if (isSelected) {
            self.imageView.backgroundColor = AppStyling.Color.systemBlack.color()
        } else {
            self.imageView.backgroundColor = AppStyling.Color.systemGray.color()
        }
    }
    
}
