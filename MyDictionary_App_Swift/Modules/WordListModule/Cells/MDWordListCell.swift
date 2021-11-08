//
//  MDWordListCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 26.09.2021.
//

import MGSwipeTableCell

final class MDWordListCell: MGSwipeTableCell,
                            MDReuseIdentifierProtocol {
    
    fileprivate static let titleLabelTopOffset: CGFloat = 16
    fileprivate static let titleLabelLeftOffset: CGFloat = 16
    fileprivate static var titleLabelRightOffset: CGFloat {
        return arrowImageViewSize.width + arrowImageViewRightOffset + 16
    }
    fileprivate static let titleLabelFont: UIFont = MDUIResources.Font.MyriadProSemiBold.font()
    fileprivate static let titleLabelNumberOfLines: Int = .zero
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = titleLabelFont
        label.textAlignment = .left
        label.textColor = MDUIResources.Color.md_3C3C3C.color()
        label.numberOfLines = titleLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate static let descriptionLabelTopOffset: CGFloat = 8
    fileprivate static let descriptionLabelLeftOffset: CGFloat = 16
    fileprivate static var descriptionLabelRightOffset: CGFloat {
        return arrowImageViewSize.width + arrowImageViewRightOffset + 16
    }
    fileprivate static let descriptionLabelFont: UIFont = MDUIResources.Font.MyriadProRegular.font(ofSize: 15)
    fileprivate static let descriptionLabelNumberOfLines: Int = .zero
    fileprivate let descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.font = descriptionLabelFont
        label.textAlignment = .left
        label.textColor = MDUIResources.Color.md_3C3C3C.color(0.7)
        label.numberOfLines = descriptionLabelNumberOfLines
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
extension MDWordListCell: MDFillWithModelProtocol {
    
    typealias Model = MDWordListCellModel?
    
    func fillWithModel(_ model: MDWordListCellModel?) {
        self.titleLabel.text = model?.wordResponse.wordText
        self.descriptionLabel.text = model?.wordResponse.wordDescription
    }
    
}

// MARK: - Public Methods
extension MDWordListCell {
    
    public static func height(tableViewWidth tvWidth: CGFloat,
                              model: MDWordListCellModel) -> CGFloat {
        
        //
        let titleLabelWidth: CGFloat = (tvWidth - (titleLabelLeftOffset + titleLabelRightOffset))
        //
        
        //
        let descriptionLabelWidth: CGFloat = (tvWidth - (descriptionLabelLeftOffset + descriptionLabelRightOffset))
        //
        
        //
        let titleLabelHeight: CGFloat = model.wordResponse.wordText!.heightFromLabel(font: titleLabelFont,
                                                                                    width: titleLabelWidth,
                                                                                    numberOfLines: titleLabelNumberOfLines)
        //
        
        //
        let descriptionLabelHeight: CGFloat = model.wordResponse.wordDescription!.heightFromLabel(font: descriptionLabelFont,
                                                                                                 width: descriptionLabelWidth,
                                                                                                 numberOfLines: descriptionLabelNumberOfLines)
        //
        
        return titleLabelHeight + titleLabelTopOffset + descriptionLabelHeight + descriptionLabelTopOffset + 16
        
    }
    
}

// MARK: - Add Views
fileprivate extension MDWordListCell {
    
    func addViews() {
        addTitleLabel()
        addDescriptionLabel()
        addArrowImageView()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
    func addDescriptionLabel() {
        addSubview(descriptionLabel)
    }
    
    func addArrowImageView() {
        addSubview(arrowImageView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDWordListCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
        addDescriptionLabelConstraints()
        addArrowImageViewConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualTopConstraint(item: self.titleLabel,
                                                 toItem: self,
                                                 constant: Self.titleLabelTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self,
                                                  constant: Self.titleLabelLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.titleLabel,
                                                   toItem: self,
                                                   constant: -Self.titleLabelRightOffset)
        
    }
    
    func addDescriptionLabelConstraints() {
        
        NSLayoutConstraint.addEqualConstraint(item: self.descriptionLabel,
                                              attribute: .top,
                                              toItem: self.titleLabel,
                                              attribute: .bottom,
                                              constant: Self.descriptionLabelTopOffset)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.descriptionLabel,
                                                  toItem: self,
                                                  constant: Self.descriptionLabelLeftOffset)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.descriptionLabel,
                                                   toItem: self,
                                                   constant: -Self.descriptionLabelRightOffset)
        
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
fileprivate extension MDWordListCell {
    
    func configureUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
}
