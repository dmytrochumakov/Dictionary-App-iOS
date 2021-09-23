//
//  AddCourseCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 23.09.2021.
//

import UIKit

final class AddCourseCell: UICollectionViewCell,
                           ReuseIdentifierProtocol {
    
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font()
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.textAlignment = .left
        return label
    }()
    
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

// MARK: -
extension AddCourseCell: MDFillWithModelProtocol {
    
    typealias Model = AddCourseCellModel
    
    func fillWithModel(_ model: AddCourseCellModel) {
        self.titleLabel.text = model.title
    }
    
}

// MARK: - Add Views
fileprivate extension AddCourseCell {
    
    func addViews() {
        addTitleLabel()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension AddCourseCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .right,
                                              toItem: self,
                                              attribute: .right,
                                              constant: -16)
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.titleLabel,
                                                     toItem: self,
                                                     constant: .zero)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension AddCourseCell {
    
    func configureUI() {
        configureSelfView()
    }
    
    func configureSelfView() {
        self.backgroundColor = .clear
    }
    
}
