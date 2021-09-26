//
//  MDCourseListCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import MGSwipeTableCell

final class MDCourseListCell: MGSwipeTableCell,
                              MDReuseIdentifierProtocol {
    
    fileprivate static let titleLabelLeftOffset: CGFloat = 16
    fileprivate static let titleLabelRightOffset: CGFloat = 16
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDUIResources.Font.MyriadProRegular.font()
        label.textAlignment = .left
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate static let arrowImageViewSize: CGSize = .init(width: 32, height: 32)
    fileprivate static let arrowImageViewRightOffset: CGFloat = 4
    fileprivate let arrowImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDUIResources.Image.right_arrow.image
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public static let height: CGFloat = 48
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
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
extension MDCourseListCell: MDFillWithModelProtocol {
    
    typealias Model = MDCourseListCellModel?
    
    func fillWithModel(_ model: MDCourseListCellModel?) {
        self.titleLabel.text = model?.languageName
    }
    
}

// MARK: - Add Views
fileprivate extension MDCourseListCell {
    
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
fileprivate extension MDCourseListCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
        addArrowImageViewConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self,
                                                  constant: Self.titleLabelLeftOffset)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .centerY,
                                              toItem: self.arrowImageView,
                                              attribute: .centerY,
                                              constant: .zero)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .right,
                                              toItem: self.arrowImageView,
                                              attribute: .left,
                                              constant: -Self.titleLabelRightOffset)
        
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
fileprivate extension MDCourseListCell {
    
    func configureUI() {
        configureSelfView()
    }
    
    func configureSelfView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
}
