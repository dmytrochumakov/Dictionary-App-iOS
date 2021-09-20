//
//  String+Extension.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation
import UIKit

extension String {
        
    func localized(lang: String, tableName: String) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj") ?? ""
        if let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
        } else {
            return ""
        }
    }
    
    func localized(tableName: String) -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
}

extension String {

    func widthFromLabel(font: UIFont, height: CGFloat, numberOfLines: Int = .zero) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: .zero, y: .zero, width: .greatestFiniteMagnitude, height: height))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.width
    }

}
