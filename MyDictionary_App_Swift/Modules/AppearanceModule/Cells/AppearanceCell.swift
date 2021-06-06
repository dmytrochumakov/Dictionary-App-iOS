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
    
}

// MARK: - Configure UI
fileprivate extension AppearanceCell {
    
    func configureUI() {
        configureView()
        configureTitleLabel()
    }
    
    func configureView() {
        self.backgroundColor = AppStyling.cellBackgroundColor()
    }
    
    func configureTitleLabel() {
        self.titleLabel.configure(withConfiguration: Self.titleLabelConfiguration)
    }
    
}

// MARK: - Update
fileprivate extension AppearanceCell {
    
    func updateSelfView(_ model: AppearanceRowModel) {
        self.backgroundColor = model.configurationAppearanceCell.cellViewBackgroundColor
    }
    
    func updateTitleLabel(_ model: AppearanceRowModel) {
        self.titleLabel.textColor = model.configurationAppearanceCell.labelTextColor
        self.titleLabel.text = model.titleText
        self.updateTitleLabelFont(isSelected: model.isSelected)
    }
    
    func updateTitleLabelFont(isSelected: Bool) {
        if (isSelected) {
            self.titleLabel.font = AppStyling.Font.boldSystemFont.font()
        } else {
            self.titleLabel.font = AppStyling.Font.systemFont.font()
        }
    }
    
}
