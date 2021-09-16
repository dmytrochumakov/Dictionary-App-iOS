//
//  CourseListCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import UIKit

final class CourseListCell: UICollectionViewCell,
                            ReuseIdentifierProtocol {
    
    fileprivate static let titleLabelLeftOffset: CGFloat = 16
    fileprivate static let titleLabelRightOffset: CGFloat = 16
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        label.textAlignment = .left
        label.textColor = MDAppStyling.Color.md_Black_1_Light_Appearence.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public static let height: CGFloat = 48
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
}

// MARK: - FillWithModelProtocol
extension CourseListCell: FillWithModelProtocol {
    
    typealias Model = CourseListCellModel?
    
    func fillWithModel(_ model: CourseListCellModel?) {
        self.titleLabel.text = model?.languageName
    }
    
}

// MARK: - Add Views
fileprivate extension CourseListCell {
    
    func addViews() {
        addTitleLabel()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension CourseListCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.titleLabel,
                                                     toItem: self,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self,
                                                  constant: Self.titleLabelLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.titleLabel,
                                                   toItem: self,
                                                   constant: -Self.titleLabelLeftOffset)
        
    }
    
}
