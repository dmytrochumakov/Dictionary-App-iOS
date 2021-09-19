//
//  PasswordToggleVisibilityView.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 12.09.2021.
//

import UIKit

protocol PasswordToggleVisibilityDelegate: AnyObject {
    func viewWasToggled(isSelected selected: Bool)
}

final class PasswordToggleVisibilityView: UIView {
    
    fileprivate let eyeButton: UIButton
    
    weak var delegate: PasswordToggleVisibilityDelegate?
    
    enum EyeState {
        case open
        case closed
    }
    
    var eyeState: EyeState {
        set {
            eyeButton.isSelected = newValue == .open
        }
        get {
            return eyeButton.isSelected ? .open : .closed
        }
    }
    
    override init(frame: CGRect) {
        
        self.eyeButton = UIButton(type: .custom)
        
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Don't use init with coder.")
    }
    
}

// MARK: - Setup
fileprivate extension PasswordToggleVisibilityView {
    
    func setupViews() {
        
        let padding: CGFloat = 10
        let buttonWidth = (frame.width / 2) - padding
        let buttonFrame = CGRect(x: buttonWidth + padding, y: 0, width: buttonWidth, height: frame.height)
        
        eyeButton.frame = buttonFrame
        eyeButton.backgroundColor = UIColor.clear
        eyeButton.adjustsImageWhenHighlighted = false
        eyeButton.setImage(MDAppStyling.Image.eye_closed.image, for: UIControl.State())
        eyeButton.setImage(MDAppStyling.Image.eye_open.image, for: .selected)
        eyeButton.addTarget(self, action: #selector(eyeButtonPressed), for: .touchUpInside)
        eyeButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        eyeButton.tintColor = self.tintColor
        
        self.addSubview(eyeButton)
        
    }
    
}

// MARK: - Actions
fileprivate extension PasswordToggleVisibilityView {
    
    @objc func eyeButtonPressed(_ sender: AnyObject) {
        eyeButton.isSelected = !eyeButton.isSelected
        delegate?.viewWasToggled(isSelected: eyeButton.isSelected)
    }
    
}
