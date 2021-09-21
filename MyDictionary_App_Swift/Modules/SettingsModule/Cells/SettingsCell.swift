//
//  SettingsCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import UIKit

final class SettingsCell: UICollectionViewCell,
                          ReuseIdentifierProtocol {
    
    static let height: CGFloat = 40
    
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MDAppStyling.Font.MyriadProRegular.font()
        label.textColor = MDAppStyling.Color.md_3C3C3C.color()
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    fileprivate static let arrowImageViewSize: CGSize = .init(width: 32, height: 32)
    fileprivate static let arrowImageViewRightOffset: CGFloat = 4
    fileprivate let arrowImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.right_arrow.image
        imageView.contentMode = .center
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
extension SettingsCell: FillWithModelProtocol {
    
    typealias Model = SettingsRowModel
    
    func fillWithModel(_ model: SettingsRowModel) {
        self.titleLabel.text = model.rowType.description
    }
    
}

// MARK: - Add Views
fileprivate extension SettingsCell {
    
    func addViews() {
        addTitleLabel()
        addArrowImageView()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
    func addArrowImageView() {
        addSubview(arrowImageView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension SettingsCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
        addArrowImageViewConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualTopConstraint(item: titleLabel,
                                                 toItem: self,
                                                 constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: titleLabel,
                                                  toItem: self,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .right,
                                              toItem: self.arrowImageView,
                                              attribute: .left,
                                              constant: -16)
        
        NSLayoutConstraint.addEqualBottomConstraint(item: titleLabel,
                                                    toItem: self,
                                                    constant: .zero)
        
    }
    
    func addArrowImageViewConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.arrowImageView,
                                                     toItem: self,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.arrowImageView,
                                                   toItem: self,
                                                   constant: -Self.arrowImageViewRightOffset)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.arrowImageView,
                                                   constant: Self.arrowImageViewSize.width)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.arrowImageView,
                                                    constant: Self.arrowImageViewSize.height)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension SettingsCell {
    
    func configureUI() {
        configureSelfView()
    }
    
    func configureSelfView() {
        self.backgroundColor = .clear
    }
    
}
