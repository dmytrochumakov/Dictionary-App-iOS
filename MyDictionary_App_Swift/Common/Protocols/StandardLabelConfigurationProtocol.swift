//
//  StandardLabelConfigurationProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 05.06.2021.
//

import UIKit

protocol LabelFontConfigureProtocol {
    var font: UIFont { get }
}

protocol LabelTextColorConfigureProtocol {
    var textColor: UIColor { get }
}

protocol LabelTextAlignmentConfigureProtocol {
    var textAlignment: NSTextAlignment { get }
}

protocol LabelNumberOfLinesConfigureProtocol {
    var numberOfLines: Int { get }
}

/// Include:
/// LabelFontConfigureProtocol,
/// LabelTextColorConfigureProtocol,
/// LabelTextAlignmentConfigureProtocol,
/// LabelNumberOfLinesConfigureProtocol
protocol StandardLabelConfigurationProtocol: LabelFontConfigureProtocol,
                                             LabelTextColorConfigureProtocol,
                                             LabelTextAlignmentConfigureProtocol,
                                             LabelNumberOfLinesConfigureProtocol {
    
}

struct StandardLabelConfigurationModel: StandardLabelConfigurationProtocol {
    
    var font: UIFont
    var textColor: UIColor
    var textAlignment: NSTextAlignment
    var numberOfLines: Int
    
}
