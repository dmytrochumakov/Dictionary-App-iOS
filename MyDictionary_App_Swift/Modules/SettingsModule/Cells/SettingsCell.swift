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
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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

// MARK: - FillWithModelProtocol
extension SettingsCell: FillWithModelProtocol {
    
    typealias Model = SettingsRowModel?
    
    func fillWithModel(_ model: SettingsRowModel?) {
        self.titleLabel.text = model?.titleText
    }
    
}

// MARK: - Add Views
fileprivate extension SettingsCell {
    
    func addViews() {
        addTitleLabel()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension SettingsCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
    func addTitleLabelConstraints() {
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.titleLabel,
                                                         toItem: self)
    }
    
}
