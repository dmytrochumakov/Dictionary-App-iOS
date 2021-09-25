//
//  MDAddCourseHeaderView.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.09.2021.
//

import UIKit

final class MDAddCourseHeaderView: UICollectionReusableView,
                                   ReuseIdentifierProtocol {
    
    public static let height: CGFloat = 32
    
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProSemiBold.font()
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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

// MARK: - MDFillWithModelProtocol
extension MDAddCourseHeaderView: MDFillWithModelProtocol {
    
    typealias Model = MDAddCourseHeaderViewCellModel?
    
    func fillWithModel(_ model: MDAddCourseHeaderViewCellModel?) {
        self.titleLabel.text = model?.character
    }
    
}

// MARK: - Add Views
fileprivate extension MDAddCourseHeaderView {
    
    func addViews() {
        addTitleLabel()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDAddCourseHeaderView {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self,
                                                  constant: 16)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.titleLabel,
                                                   toItem: self,
                                                   constant: -16)
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.titleLabel,
                                                     toItem: self,
                                                     constant: .zero)
        
    }
    
}

// MARK: - Configure UI
fileprivate extension MDAddCourseHeaderView {
    
    func configureUI() {
        configureSelfView()
    }
    
    func configureSelfView() {
        self.backgroundColor = .clear
    }
    
}

