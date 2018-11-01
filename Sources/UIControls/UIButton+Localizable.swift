//
//  UIButton+Localizable.swift
//  SKLocalizable
//
//  Created by Viktor Olesenko on 03.10.18.
//

import UIKit

extension UIButton {
    
    // localizationKey overrided just for IBInspectable
    @IBInspectable
    open override var localizationKey: String? {
        get { return super.localizationKey }
        set { super.localizationKey = newValue }
    }
    
    open override func localize() {
        // Setting directly in textLabel first to avoid text change animation
        self.titleLabel?.text = localizationKey?.localized(tableName: self.localizationFile)
        self.setTitle(localizationKey?.localized(tableName: self.localizationFile), for: .normal)
    }
}
