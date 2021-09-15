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
        self.updateSelfView(model)
        self.updateTitleLabel(model)
    }
    
}

// MARK: - Add Views
fileprivate extension AppearanceCell {
    
    func addViews() {
        addTitleLabel()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AppearanceCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
    func addTitleLabelConstraints() {
        NSLayoutConstraint.addEqualTopConstraint(item: titleLabel,
                                                            toItem: self,
                                                            constant: .zero)
        NSLayoutConstraint.addEqualLeftConstraint(item: titleLabel,
                                                             toItem: self,
                                                             constant: 16)
        NSLayoutConstraint.addEqualRightConstraint(item: titleLabel,
                                                              toItem: self,
                                                              constant: .zero)
        NSLayoutConstraint.addEqualBottomConstraint(item: titleLabel,
                                                               toItem: self,
                                                               constant: .zero)
    }
    
}

// MARK: - Configure UI
fileprivate extension AppearanceCell {
    
    func configureUI() {
        configureView()
        configureTitleLabel()
    }
    
    func configureView() {
        self.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor()
    }
    
    func configureTitleLabel() {
        self.updateTitleLabelFont(isSelected: false)
        self.titleLabel.textColor = ConfigurationAppearanceController.labelTextColor()
        self.titleLabel.textAlignment = .left
        self.titleLabel.numberOfLines = .zero
    }
    
}

// MARK: - Update
fileprivate extension AppearanceCell {
    
    func updateSelfView(_ model: AppearanceRowModel) {
        self.backgroundColor = ConfigurationAppearanceController.viewBackgroundColor(fromAppearanceType: model.appearanceType)
    }
    
    func updateTitleLabel(_ model: AppearanceRowModel) {
        self.titleLabel.textColor = ConfigurationAppearanceController.labelTextColor(fromAppearanceType: model.appearanceType)
        self.titleLabel.text = model.titleText
        self.updateTitleLabelFont(isSelected: model.isSelected)
    }
    
    func updateTitleLabelFont(isSelected: Bool) {
        self.titleLabel.font = self.titleLabelFont(isSelected: isSelected)
    }
    
}

// MARK: - Title Label Font
fileprivate extension AppearanceCell {
    
    func titleLabelFont(isSelected: Bool) -> UIFont {
        if (isSelected) {
            return MDAppStyling.Font.boldSystemFont.font()
        } else {
            return MDAppStyling.Font.systemFont.font()
        }
    }
    
}
